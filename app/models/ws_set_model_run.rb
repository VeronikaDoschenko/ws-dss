class WsSetModelRun < ActiveRecord::Base
  nilify_blanks
  has_and_belongs_to_many :ws_model_runs
  validates :name, presence: true
end
