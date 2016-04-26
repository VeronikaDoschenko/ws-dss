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
        mr.param_values.where("param_values.old_value is null and
          exists(select 1 from ws_param_models where param_values.ws_param_id = ws_param_models.ws_param_id and
                                                     ws_model_runs.ws_model_id = ws_param_models.ws_model_id and
                                                     ws_param_models.is_required = 1
                )                       
        ").each do |pv|
          can_run = false
          # find source
          if pv.ws_set_model_run.nil?
            mr.trace += "\nCan not find source for param #{pv.ws_param.name}"
            return
          end
          pv.ws_set_model_run.ws_model_runs.each do |smr|
            case smr.ws_model_status_id
            when 1
              smr.update(ws_model_status_id: 7)
            when 4
              # copy value
              value = []
              pv.source_ws_params.each do |sp| 
                spv = smr.param_values.find_by_ws_param_id(sp.id)
                if spv.nil? or spv.new_value.blank?
                  mr.trace += "\nCan not find source for param #{pv.ws_param.name} in #{smr.name}"
                  return
                end
                value << spv.new_value
              end
            end
          end
          
        end
        mr.update(ws_model_status_id: 2) if can_run        
      when 4
        # transfer param_values if all set
        # and run models if they are waiting and can run
      end      
    end
  end
end
