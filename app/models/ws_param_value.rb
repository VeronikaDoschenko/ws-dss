class WsParamValue < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_param
  belongs_to :ws_model_run
  belongs_to :ws_set_model_run
end
