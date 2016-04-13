class WsSetModelRun < ActiveRecord::Base
  nilify_blanks
  has_and_belongs_to_many :ws_model_runs
  has_many :ws_param_values
  validates :name, presence: true
end
