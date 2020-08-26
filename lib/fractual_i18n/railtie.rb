require "rails/railtie"

class FractualI18n::Railtie < Rails::Railtie
  initializer "fractual_i18n.set_fractual_paths" do |app|
    FractualI18n.configuration.fractual_paths = app.config.paths["app/views"].existent
  end
end
