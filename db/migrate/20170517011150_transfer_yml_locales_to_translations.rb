class TransferYmlLocalesToTranslations < ActiveRecord::Migration
  include TranslationsHelper
  def change

  	translation_keys(:ru).each do |tk|
  		tr = Translation.new(
  			:locale => "ru",
  			:key => tk,
  			:value => I18n.t(tk.split('.').drop(1).join('.'))
  			)
  		tr.save!
  	end

  	I18n.locale = :en
  	translation_keys(:en).each do |tk|
  		tr = Translation.new(
  			:locale => "en",
  			:key => tk,
  			:value => I18n.t(tk.split('.').drop(1).join('.'))
  			)
  		tr.save!
  	end

  end
end
