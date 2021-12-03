# frozen_string_literal: true

class FractualI18n::Phrases
  def joined(locale:)
    original_load_path = I18n.load_path

    I18n.load_path = fractual_files
    I18n.with_locale(locale) { I18n.t(".") }
  ensure
    I18n.load_path = original_load_path
  end

  def store(translations, locale:)
    fractual_files.each do |filename|
      content = YAML.load_file(filename)

      fractual_path = FractualI18n.configuration.fractual_paths.find { |path| filename.starts_with?(path) }
      keys = filename.delete_prefix(fractual_path).delete_prefix("/").split("/")
      last_key = keys.pop.delete_suffix(".yml")
      keys << last_key
      keys.map! { |key| key.delete_prefix("_") } # remove underscore from partial name

      if new_content = translations.dig(locale.to_s, *keys)
        content[locale.to_s] = content.fetch(locale.to_s, {}).merge(new_content)
      end

      File.write(filename, content.to_yaml(line_width: 200))
    end
  end

  private

  def fractual_files
    I18n.load_path.select do |path|
      FractualI18n.configuration.fractual_paths.any? { |fp| path.starts_with?(fp) }
    end
  end
end
