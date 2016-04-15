class WsParam < ActiveRecord::Base
  nilify_blanks
  belongs_to :user
  has_many :ws_param_values
  has_and_belongs_to_many :target_ws_param_values, class_name: 'WsParamValue'
  
  validates :name, :dim, presence: true

end
