class PagesController < ApplicationController
  def show
    @page = Page.create_or_find_by(title: params[:title], language: language)
    if @page.body
      return
    end
    SearchReferencesJob.perform_later(page_id: @page.id)
  end
end
