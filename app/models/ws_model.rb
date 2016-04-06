class WsModel < ActiveRecord::Base
  has_many :ws_param_models, :dependent => :destroy
  accepts_nested_attributes_for :ws_param_models, allow_destroy: true
end
