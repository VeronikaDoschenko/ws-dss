class WsParamModel < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_model
  belongs_to :ws_param
  validates :ws_model, :ws_param, presence: true
  validates_uniqueness_of :ws_param_id, :scope => [:ws_model_id]
end
