class WsModelRunsSetModelRun < ActiveRecord::Base
  belongs_to :ws_model_run
  belongs_to :ws_set_model_run
  
  validates :ord, uniqueness: { scope: :ws_set_model_run, message: "Порядковый номер прогона должен быть уникальным в рамках множества" }
end