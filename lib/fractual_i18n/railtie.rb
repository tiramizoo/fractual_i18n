# frozen_string_literal: true

require "rails/railtie"

class FractualI18n::Railtie < Rails::Railtie
  initializer "fractual_i18n.set_fractual_paths" do |app|
    FractualI18n.configuration.fractual_paths = app.config.paths["app/views"].existent
  end

  rake_tasks do
    load "tasks/fractual_i18n.rake"
  end
end
