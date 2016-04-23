class WsParamValue < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_param
  belongs_to :ws_model_run
  belongs_to :ws_set_model_run
  
  has_many :ws_param_values_params
  
  has_and_belongs_to_many :source_ws_params, class_name: 'WsParam', through: :ws_param_values_params
  
  accepts_nested_attributes_for :ws_param_values_params, :allow_destroy => true
  
end
