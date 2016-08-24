class WsModelRun < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_model
  belongs_to :ws_model_status
  belongs_to :user
  belongs_to :ws_set_model_run
  belongs_to :target_ws_model, class_name: 'WsModel'
  belongs_to :goal_ws_param_value, class_name: 'WsParamValue'
  has_many   :ws_model_runs_set_model_runs, :dependent => :destroy
  has_many   :ws_set_model_runs, through: :ws_model_runs_set_model_runs
  validates  :ws_model, :ws_model_status, presence: true
  has_many   :ws_param_values, :dependent => :destroy
  accepts_nested_attributes_for :ws_param_values, allow_destroy: true
  
  royce_roles %w[ public ] + User.available_roles.collect{|s| s.name} - %w[ admin ]
  
  before_save do |mr|
    if mr.ws_model_status_id_changed? 
      case mr.ws_model_status_id
      when 2
        mr.trace = "Starting trace" if mr.ws_model.ws_method
      when 7
        mr.trace = "Preparing data"
      end
    end
  end
  
  after_save do |mr|
    if mr.ws_model_status_id_changed?  # like state mashine
      case mr.ws_model_status_id
      when 1
        mr.ws_param_values.each {|pv| pv.update(new_value: nil)}
        mr.update_columns(trace: nil)
      when 2
        if mr.ws_model.ws_method    
          CalcWsModelRunWorker.perform_async( mr.id )
        end
      when 7
        prep_model_run( mr )
      when 4
        mr.ws_param_values.each do |pv|
          if pv.new_value.blank? and
             mr.ws_model.ws_param_models.find_by_ws_param_id(pv.ws_param_id).is_copy
            pv.update(new_value: pv.old_value)
          end
        end
        store_res(mr) if mr.ws_set_model_run and mr.target_ws_model
        mr.ws_set_model_runs.each do |ms|
          ms.ws_param_values.joins(:ws_model_run).where('ws_model_runs.ws_model_status_id = 7').each do |pv|
            prep_model_run(pv.ws_model_run)
          end
        end
      end      
    end
  end
  
  def store_res mr
    mname = mr.name
    need_next = false
    need_goal = false
    h = {}
    i = 0
    mr.ws_param_values.each do |pv|
      if pv.formula
        a = eval(pv.formula)
        i = a.index(pv.old_value.to_i)
        if i
          if i == 0
            mr.ws_set_model_run.ws_model_runs.where("ws_model_runs.name in
                   ("+a.collect{|t| "'#{mr.name} #{t}'"}.join(', ')+")").destroy_all
          end
          mname += ' ' + pv.old_value
          i += 1
          if i < a.size
            need_next = true
            h[pv.id] = { old_value: a[i].to_s }
          elsif i == a.size
            need_goal = true
          end
        end
      end
    end
        
    nmr = WsModelRun.create( name:               mname,
                             ws_model:           mr.target_ws_model,
                             descr:              mr.trace, 
                             ws_model_status_id: 7,
                             user_id:            mr.user_id
                           )
    
    mr.ws_set_model_run.with_lock do
      nn = mr.ws_set_model_run.ws_model_runs_set_model_runs.size + 1
      mr.ws_set_model_run.ws_model_runs_set_model_runs.create(ord: nn, ws_model_run: nmr)
    end
    
    mr.target_ws_model.ws_param_models.each do |pm|
      pv  = nmr.ws_param_values.create(ws_param: pm.ws_param)
      spv = mr.ws_param_values.find_by_ws_param_id( pv.ws_param_id )   
      pv.update(old_value: (spv.new_value || spv.old_value)) if spv
    end
    

    if need_next
      WsParamValue.update(h.keys, h.values)
      mr.update(ws_model_status_id: 2)
    elsif need_goal and mr.goal_ws_param_value
      mr.goal_ws_param_value.ws_model_run.update(ws_model_status_id: 7) # prep to run
    end 
  end
  
  private
    def prep_model_run( mr )
      mr.with_lock do
      can_run = true
      mr.ws_param_values.where("exists(select 1
                                    from   ws_param_models
                                    where  ws_param_values.ws_param_id  = ws_param_models.ws_param_id and
                                           #{mr.ws_model_id} = ws_param_models.ws_model_id and
                                           ws_param_models.is_required = true
              )                       
      ").each do |pv|
        if pv.ws_set_model_run.nil?
          if pv.old_value.blank?
            mr.trace += "\nCan not find source for param #{pv.ws_param.name}"
            can_run = false
          end
        elsif pv.source_ws_params.size == 0
          mr.trace += "\nCan not find source params for param #{pv.ws_param.name}"
          can_run = false
        elsif pv.ws_set_model_run.ws_model_runs.size == 0
          mr.trace += "\nCan not find runs in set #{pv.ws_set_model_run.name} for param #{pv.ws_param.name}"
          can_run = false
        else
          pov = Array.new(pv.source_ws_params.size) {Array.new(pv.ws_set_model_run.ws_model_runs.size)}
          pv.source_ws_params.order('ws_param_values_params.ord').each_with_index do |sp, j|
            pv.ws_set_model_run.ws_model_runs.order('ws_model_runs_set_model_runs.ord').each_with_index do |smr,i|
              case smr.ws_model_status_id
              when 1
                smr.update(ws_model_status_id: 7)
                can_run = false
              when 4
                spv = smr.ws_param_values.find_by_ws_param_id(sp.id)
                if spv.nil? or (spv.new_value.blank? and spv.old_value.blank? )
                  mr.trace += "\nCan not find source for param #{pv.ws_param.name} in #{smr.name}"
                  can_run = false
                else
                  vv = spv.new_value || spv.old_value
                  if (not vv['"']) and vv['e ']
                    vv['e '] = 'e'
                  end
                  
                  pov[j][i]=JSON.parse("[#{vv}]")[0]
                end
              when 5
                mr.trace += "\nError value in source model run #{smr.name} for param #{pv.ws_param.name}"
                can_run = false
              when 6
                mr.trace += "\nError in source model run #{smr.name} for param #{pv.ws_param.name}"
                can_run = false
              else
                can_run = false
              end
            end
          end
          if can_run
            pov = pov[0] if pov.size == 1
            pov.map!{|x| (x.kind_of?(Array) and x.size == 1)?x[0]:x }
            pov = pov[0] if pov.kind_of?(Array) and pov.size == 1
            pv.update( old_value: (pov.kind_of?(Array)?JSON.pretty_generate(pov):pov) )
          end
        end
      end
      unless mr.trace.blank?
          mr.update_columns(trace: mr.trace)
      end
      mr.update(ws_model_status_id: 2) if can_run   
      end
    end
end
