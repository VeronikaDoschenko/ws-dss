class WsJob < ActiveRecord::Base
  belongs_to :ws_method
  belongs_to :user

end
