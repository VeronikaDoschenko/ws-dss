class WsParamValue < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_param
  belongs_to :ws_model_run
  belongs_to :ws_set_model_run
  
  has_many   :ws_param_values_params
  has_many   :solver_ws_model_runs, foreign_key: "goal_ws_param_value_id", class_name: 'WsModelRun'
  
  has_and_belongs_to_many :source_ws_params, class_name: 'WsParam', through: :ws_param_values_params
  
  validates  :ws_param_id, :ws_model_run_id, presence: true
  validates_uniqueness_of :ws_param_id, :scope => [:ws_model_run_id]
  
  accepts_nested_attributes_for :ws_param_values_params, :allow_destroy => true
  scope :full_info,-> do
    joins([{ws_model_run: :ws_model}, :ws_param]).order('ws_models.name, ws_model_runs.name, ws_params.name')
  end
  def full_name
    "#{ws_model_run.ws_model.name}/#{ws_model_run.name}/#{ws_param.name}"
  end
end
