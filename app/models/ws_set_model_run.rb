class WsSetModelRun < ActiveRecord::Base
  nilify_blanks
  validates :name, presence: true
end
