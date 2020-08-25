module FractualI18n::Backend
  def load_yml(filename)
    if filename.include?("app/views")
      res = YAML.load_file(filename)
      keys = filename.gsub("#{Rails.root}/app/views/", "").split("/")
      last_key = keys.pop.gsub(".yml", "")
      keys << last_key
      keys.map! { |key| key.gsub(/\A_/, "") } # remove underscore from partial name
      I18n.available_locales.each_with_object({}) do |locale, translations|
        next if res[locale.to_s].blank?

        translations[locale] = keys.reverse.inject(res[locale.to_s]) { |translation, key| { key => translation } }
      end
    else # default
      YAML.load_file(filename)
    end
  rescue TypeError, ScriptError, StandardError => e
    raise I18n::InvalidLocaleData.new(filename, e.inspect)
  end
end
