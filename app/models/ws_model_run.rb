class WsModelRun < ActiveRecord::Base
  belongs_to :ws_model
  belongs_to :ws_model_status
  has_many   :ws_param_values, :dependent => :destroy
  accepts_nested_attributes_for :ws_param_values, allow_destroy: true
end
