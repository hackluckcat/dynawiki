class PagesController < ApplicationController
  def show
    @page = Page.create_or_find_by(title: params[:title], language: language)
    SearchReferencesJob.perform_later(query: @page.title)
  end
end
