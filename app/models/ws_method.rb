class WsMethod < ActiveRecord::Base
  has_many :descriptions, as: :rec
  def descr
    d = self.descriptions.where(:locale => I18n.locale).first
    return d ? d.descr : ""
  end
end
