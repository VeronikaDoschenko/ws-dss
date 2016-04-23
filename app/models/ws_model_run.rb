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
    if mr.ws_model.ws_method and mr.ws_model_status.id == 2
      mr.trace = "Starting trace"
    end
  end
  
  after_save do |mr|
    if mr.ws_model.ws_method and mr.ws_model_status.id == 2
      system "rake ws_dss:process_ws_model_run[#{mr.id}] --trace 2>&1 >> #{Rails.root.join('log',"#{Rails.env}.log")} &"
    end
  end
end
