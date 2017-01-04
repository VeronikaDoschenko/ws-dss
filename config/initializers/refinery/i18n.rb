# encoding: utf-8

Refinery::I18n.configure do |config|
  config.default_locale = :ru

  config.current_locale = :ru

  config.default_frontend_locale = :ru

  config.frontend_locales = [:ru, :en]

  config.locales = {:en=>"English", :ru=>"Русский"}
end
