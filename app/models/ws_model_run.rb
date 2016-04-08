class WsModelRun < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_model
  belongs_to :ws_model_status
  belongs_to :user
  validates  :ws_model, :ws_model_status, presence: true
  has_many   :ws_param_values, :dependent => :destroy
  accepts_nested_attributes_for :ws_param_values, allow_destroy: true
end
