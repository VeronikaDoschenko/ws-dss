class WsMethod < ActiveRecord::Base
  has_many :descriptions, as: :rec
end
