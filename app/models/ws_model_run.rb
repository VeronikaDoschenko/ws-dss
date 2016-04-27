class WsModelRun < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_model
  belongs_to :ws_model_status
  belongs_to :user
  has_many :ws_model_runs_set_model_runs
  has_many :ws_set_model_runs, through: :ws_model_runs_set_model_runs
  validates  :ws_model, :ws_model_status, presence: true
  has_many   :ws_param_values, :dependent => :destroy
  accepts_nested_attributes_for :ws_param_values, allow_destroy: true
  
  before_save do |mr|
    if mr.ws_model.ws_method and mr.ws_model_status_id_changed? 
      case mr.ws_model_status_id
      when 2
        mr.trace = "Starting trace"
      when 7
        mr.trace = "Preparing data"
      end
    end
  end
  
  after_save do |mr|
    if mr.ws_model.ws_method and mr.ws_model_status_id_changed?  # like state mashine
      case mr.ws_model_status_id
      when 2
        system "rake ws_dss:process_ws_model_run[#{mr.id}] --trace 2>&1 >> #{Rails.root.join('log',"#{Rails.env}.log")} &"
      when 7
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
            pv.source_ws_params.each_with_index do |sp, j|
              pv.ws_set_model_run.ws_model_runs.each_with_index do |smr,i|
                case smr.ws_model_status_id
                when 1
                  smr.update(ws_model_status_id: 7)
                  can_run = false
                when 4
                  spv = smr.param_values.find_by_ws_param_id(sp.id)
                  if spv.nil? or spv.new_value.blank?
                    mr.trace += "\nCan not find source for param #{pv.ws_param.name} in #{smr.name}"
                    can_run = false
                  else
                    pov[j][i]=spv.new_value
                  end
                when 5
                  mr.trace += "\nError value in source model run #{smr.name} for param #{pv.ws_param.name}"
                  can_run = false
                when 6
                  mr.trace += "\nError in source model run #{smr.name} for param #{pv.ws_param.name}"
                  can_run = false
                end
              end
            end
            pv.update( old_value: pov.to_s ) if can_run
          end
        end
        unless mr.trace.blank?
            self.update_columns(trace: mr.trace)
        end
        
        mr.update(ws_model_status_id: 2) if can_run        
      when 4
        # transfer param_values if all set
        # and run models if they are waiting and can run
      end      
    end
  end
end
