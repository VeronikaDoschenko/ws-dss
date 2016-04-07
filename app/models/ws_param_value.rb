class WsParamValue < ActiveRecord::Base
  belongs_to :ws_param
  belongs_to :ws_model_run
end
