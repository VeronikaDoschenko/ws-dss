class WsModelRun < ActiveRecord::Base
  belongs_to :ws_model
  belongs_to :ws_model_status
end
