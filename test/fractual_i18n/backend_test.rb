require "test_helper"

class FractualI18n::BackendTest < Minitest::Test
  include FractualI18nTestHelper

  def setup
    super
    FractualI18n.configuration.fractual_paths = [fixtures_path("views")]
    FractualI18n.configuration.available_locales = [:en]
  end

  def test_fractual_file_is_namespaced_by_path
    I18n.load_path = [fixtures_path("views/users/index.yml")]
    assert_equal "Users List", I18n.t("users.index.title", locale: :en)
  end

  def test_partial_underscore_is_stripped
    I18n.load_path = [fixtures_path("views/users/_form.yml")]
    assert_equal "Save User", I18n.t("users.form.submit", locale: :en)
  end

  def test_deeply_nested_directory
    I18n.load_path = [fixtures_path("views/admin/dashboard/show.yml")]
    assert_equal "Welcome Admin", I18n.t("admin.dashboard.show.welcome", locale: :en)
  end

  def test_non_fractual_file_loads_normally
    I18n.load_path = [fixtures_path("locales/regular.yml")]
    assert_equal "Hello", I18n.t("greeting", locale: :en)
  end

  def test_multiple_locales
    FractualI18n.configuration.available_locales = [:en, :pl]
    I18n.load_path = [fixtures_path("views/users/index.yml")]
    assert_equal "Users List", I18n.t("users.index.title", locale: :en)
    assert_equal "Lista użytkowników", I18n.t("users.index.title", locale: :pl)
  end

  def test_multiple_fractual_files_together
    I18n.load_path = [
      fixtures_path("views/users/index.yml"),
      fixtures_path("views/users/_form.yml"),
      fixtures_path("views/admin/dashboard/show.yml")
    ]
    assert_equal "Users List", I18n.t("users.index.title", locale: :en)
    assert_equal "Save User", I18n.t("users.form.submit", locale: :en)
    assert_equal "Welcome Admin", I18n.t("admin.dashboard.show.welcome", locale: :en)
  end

  def test_fractual_and_non_fractual_files_together
    I18n.load_path = [
      fixtures_path("views/users/index.yml"),
      fixtures_path("locales/regular.yml")
    ]
    assert_equal "Users List", I18n.t("users.index.title", locale: :en)
    assert_equal "Hello", I18n.t("greeting", locale: :en)
  end
end
