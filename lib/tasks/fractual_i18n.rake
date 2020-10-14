namespace :fractual_i18n do
  desc "Export view translations to single file"
  task :export, [:to] => :environment do |_task, args|
    require "fractual_i18n/phrases"
    destination = args[:to] || "tmp/fractual_i18n/exported"

    FileUtils.mkdir_p(destination)
    FractualI18n.configuration.available_locales.each do |locale|
      translations = FractualI18n::Phrases.new.joined(locale: locale)
      Dir.chdir(destination) do
        content = {locale.to_s => translations.deep_stringify_keys}.to_yaml(line_width: 200)
        File.write("#{locale}.yml", content)
        puts "#{destination}/#{locale}.yml exported"
      end
    end
  end

  desc "Import view translations from single file"
  task :import, [:from] => :environment do |_task, args|
    require "fractual_i18n/phrases"
    destination = args[:from] || "tmp/fractual_i18n/import"

    Dir.each_child(destination) do |file|
      content = YAML.load_file("#{destination}/#{file}")
      locale = content.keys.first

      FractualI18n::Phrases.new.store(content, locale: locale)
    end
  end
end
