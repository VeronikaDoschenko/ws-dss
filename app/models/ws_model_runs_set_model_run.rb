class WsModelRunsSetModelRun < ActiveRecord::Base
  belongs_to :ws_model_run
  belongs_to :ws_set_model_run
end