class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_locale

  helper_method :language

  def language
    @language ||= Language.find_by(code: params[:code])
  end

  private def set_locale
    I18n.locale = language.code
  end
end
