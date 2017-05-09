module I18n
  class << self

    def get_keys(hsh = nil, parent = nil, ary = [])
      locale = I18n.locale
      hsh = YAML.load_file("config/locales/#{locale}.yml") unless hsh
      keys = hsh.keys
      keys.each do |key|
        if hsh.fetch(key).is_a?(Hash)
          get_keys(hsh.fetch(key), "#{parent}.#{key}", ary)
        else
          keys.each do |another|
            ary << "#{parent}.#{another}"[1..-1]
          end
        end
      end
      ary.uniq
    end

  end
end
