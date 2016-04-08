class WsModel < ActiveRecord::Base
  nilify_blanks
  belongs_to :user
  has_many :ws_param_models, :dependent => :destroy
  accepts_nested_attributes_for :ws_param_models, allow_destroy: true
  
  validates :name, presence: true
  
end
