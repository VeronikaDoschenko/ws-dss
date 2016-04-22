class WsSetModelRun < ActiveRecord::Base
  nilify_blanks
  has_many :ws_model_runs_set_model_runs
  has_many :ws_model_runs, through: :ws_model_runs_set_model_runs
  has_many :ws_param_values
  accepts_nested_attributes_for :ws_model_runs_set_model_runs, :allow_destroy => true

  validates :name, presence: true
  
end
