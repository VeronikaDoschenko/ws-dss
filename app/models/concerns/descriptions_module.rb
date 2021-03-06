module DescriptionsModule
  extend ActiveSupport::Concern

  included do
    has_many :descriptions, as: :rec, dependent: :destroy
  end

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