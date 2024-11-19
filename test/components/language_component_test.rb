# frozen_string_literal: true

require "test_helper"

class LanguageComponentTest < ViewComponent::TestCase
  def test_component_when_current
    rendered = render_inline(LanguageComponent.new(language: :en, current: :en))
    assert_equal(
      "English",
      rendered.css("span").text.strip
    )
  end

  def test_component_when_not_current
    rendered = render_inline(LanguageComponent.new(language: :en, current: :ja))
    assert_equal(
      "/en",
      rendered.css("a")[0][:href]
    )
    assert_equal(
      "English",
      rendered.css("a")[0].text.strip
    )
  end
end
