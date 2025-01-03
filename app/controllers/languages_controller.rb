class LanguagesController < ApplicationController
  before_action :set_locale, except: :index

  def index
    if preferred_language.in?(language_codes)
      redirect_to "/#{preferred_language}"
    else
      redirect_to "/en"
    end
  end

  def show
  end

  private def preferred_language
    request.env["HTTP_ACCEPT_LANGUAGE"]&.scan(/^[a-z]{2}/)&.first
  end
end
