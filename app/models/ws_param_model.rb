class WsParamModel < ActiveRecord::Base
  belongs_to :ws_model
  belongs_to :ws_param
end
