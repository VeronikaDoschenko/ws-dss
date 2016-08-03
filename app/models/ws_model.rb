class WsModel < ActiveRecord::Base
  nilify_blanks
  belongs_to :user
  has_many :ws_param_models, :dependent => :destroy
  belongs_to :ws_method
  
  accepts_nested_attributes_for :ws_param_models, allow_destroy: true
  
  validates :name, presence: true
  
  royce_roles %w[ public ] + User.available_roles.collect{|s| s.name}
  
end
