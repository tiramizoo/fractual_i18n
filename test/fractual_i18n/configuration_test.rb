require "test_helper"

class FractualI18n::ConfigurationTest < Minitest::Test
  def setup
    @config = FractualI18n::Configuration.new
  end

  def test_default_fractual_paths_is_empty
    assert_equal [], @config.fractual_paths
  end

  def test_default_available_locales_from_i18n
    assert_equal I18n.available_locales, @config.available_locales
  end

  def test_setting_fractual_paths
    @config.fractual_paths = ["/app/views"]
    assert_equal ["/app/views"], @config.fractual_paths
  end

  def test_setting_available_locales
    @config.available_locales = [:en, :de]
    assert_equal [:en, :de], @config.available_locales
  end
end
