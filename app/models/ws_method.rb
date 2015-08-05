class WsMethod < ActiveRecord::Base
  nilify_blanks
  
  has_many :descriptions, as: :rec, dependent: :destroy
  has_many :ws_jobs, dependent: :restrict_with_exception

  def descr
    d = self.descriptions.where(:locale => I18n.locale).first
    return d ? d.descr : ""
  end

  def descr=(x)
    d = self.descriptions.where(:locale => I18n.locale).first
    if d      
      d.update(:descr => x)
    else
      self.descriptions.new(:locale => I18n.locale, :descr => x)
    end
    return x
  end
  
end
