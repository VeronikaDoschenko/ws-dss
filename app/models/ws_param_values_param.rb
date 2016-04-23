class WsParamValuesParam < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_param
  belongs_to :ws_param_value
  
  validates :ord, uniqueness: { scope: :ws_param_value, message: "Порядковый номер параметра должен быть уникальным для источника" }
end
