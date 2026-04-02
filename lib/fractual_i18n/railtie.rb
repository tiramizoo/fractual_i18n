# frozen_string_literal: true

require "rails/railtie"

class FractualI18n::Railtie < Rails::Railtie
  initializer "fractual_i18n.set_fractual_paths" do |app|
    FractualI18n.configuration.fractual_paths = app.config.paths["app/views"].existent
  end

  config.after_initialize do |app|
    if app.config.enable_reloading
      app.reloader.to_prepare do
        current_yml_files = FractualI18n.configuration.fractual_paths.flat_map { |fp| Dir["#{fp}/**/*.yml"] }
        new_files = current_yml_files - I18n.load_path
        if new_files.any?
          I18n.load_path.concat(new_files)
          I18n.reload!
        end
      end
    end
  end

  rake_tasks do
    load "tasks/fractual_i18n.rake"
  end
end
