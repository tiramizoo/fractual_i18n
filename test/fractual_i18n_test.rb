require "test_helper"

class FractualI18nTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil FractualI18n::VERSION
  end

  def test_configure_yields_configuration
    FractualI18n.configure do |config|
      assert_instance_of FractualI18n::Configuration, config
    end
  end

  def test_configuration_returns_same_instance
    assert_same FractualI18n.configuration, FractualI18n.configuration
  end
end
