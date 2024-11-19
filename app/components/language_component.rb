# frozen_string_literal: true

class LanguageComponent < ViewComponent::Base
  def initialize(language:, current:)
    @language = language
    @current = current
  end
end
