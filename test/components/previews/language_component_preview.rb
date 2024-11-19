class LanguageComponentPreview < ViewComponent::Preview
  def not_current
    render(LanguageComponent.new(language: :en, current: :ja))
  end

  def current
    render(LanguageComponent.new(language: :en, current: :en))
  end
  
  def collection
    render(
      LanguageComponent.with_collection(
        %i(en ja),
        current: :en,
        spacer_component: LanguageSpacerComponent.new
      )
    )
  end
end
