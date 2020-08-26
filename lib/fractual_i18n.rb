require "i18n"
require "fractual_i18n/version"
require "fractual_i18n/configuration"
require "fractual_i18n/backend"
require "fractual_i18n/railtie" if defined?(Rails)

module FractualI18n
  def self.configuration
    @configuration ||= FractualI18n::Configuration.new
  end

  def self.configure
    yield configuration
  end
end
