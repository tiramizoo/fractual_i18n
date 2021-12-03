# frozen_string_literal: true

module FractualI18n::Backend
  def load_yml(filename)
    if (fractual_path = FractualI18n.configuration.fractual_paths.find { |path| filename.starts_with?(path) })
      content = YAML.load_file(filename)
      keys = filename.delete_prefix(fractual_path).delete_prefix("/").split("/")
      last_key = keys.pop.delete_suffix(".yml")
      keys << last_key
      keys.map! { |key| key.delete_prefix("_") } # remove underscore from partial name
      FractualI18n.configuration.available_locales.each_with_object({}) do |locale, translations|
        next unless content[locale.to_s]

        translations[locale] = keys.reverse.inject(content[locale.to_s]) { |translation, key| { key => translation } }
      end
    else # default
      YAML.load_file(filename)
    end
  rescue TypeError, ScriptError, StandardError => e
    raise I18n::InvalidLocaleData.new(filename, e.inspect)
  end
end
