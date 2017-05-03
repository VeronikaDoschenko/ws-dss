class WsParam < ActiveRecord::Base
  nilify_blanks
  belongs_to :user
  has_many :descriptions, as: :rec, dependent: => :destroy
  has_many :ws_param_values
  has_many :ws_param_values_params
  has_many :target_ws_param_values, class_name: 'WsParamValue', through: :ws_param_values_params
  
  accepts_nested_attributes_for :ws_param_values_params, :allow_destroy => true
  
  validates :name, :dim, presence: true

end
