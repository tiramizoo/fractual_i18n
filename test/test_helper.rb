$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "fractual_i18n"

require "minitest/autorun"

FIXTURES_PATH = File.expand_path("fixtures", __dir__)

module FractualI18nTestHelper
  def setup
    @original_backend = I18n.backend
    @original_load_path = I18n.load_path.dup
    @original_available_locales = I18n.available_locales

    I18n::Backend::Simple.include(FractualI18n::Backend)
  end

  def teardown
    I18n.backend = @original_backend
    I18n.load_path = @original_load_path
    I18n.available_locales = @original_available_locales
  end

  def fixtures_path(*parts)
    File.join(FIXTURES_PATH, *parts)
  end
end
