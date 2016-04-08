class WsParam < ActiveRecord::Base
  nilify_blanks
  belongs_to :user
  has_many :ws_param_values
  
  validates :name, :dim, presence: true

end
