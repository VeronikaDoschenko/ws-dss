module TranslationsHelper

  def translation_keys(i18n_locale)
    case i18n_locale
    when "en"
      en_keys
    when "ru"
      ru_keys
    else
      default_keys
    end
  end

  def translation_for_key(translations, key)
    hits = translations.to_a.select{ |t| t.key == key }
    hits.first
  end

  private

  def en_keys
    I18n.get_keys
  end

  def ru_keys
    I18n.get_keys
  end

  def default_keys
    I18n.get_keys
  end
end