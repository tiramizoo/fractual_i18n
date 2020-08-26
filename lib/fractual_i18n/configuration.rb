class FractualI18n::Configuration
  attr_accessor :available_locales, :fractual_paths

  def initialize
    @available_locales = I18n.available_locales
    @fractual_paths = []
  end
end
