# frozen_string_literal: true

require "open-uri"

class SearchReferencesJob < ApplicationJob
  queue_as :default

  def perform(page_id:)
    page = Page.find(page_id)
    urls = GoogleSearchResult.new(query: page.title).urls
    Turbo::StreamsChannel.broadcast_update_to(
      :page,
      target: "status",
      partial: "pages/loading",
    )
    page.references.destroy_all
    urls.each do |url|
      html_content = URI.open(url)
      reference = Reference.from_html(html_content:, url:)
      page.references << reference
      Turbo::StreamsChannel.broadcast_append_to(
        :page,
        target: "references",
        partial: "references/item",
        locals: { reference: }
      )
    end
    Turbo::StreamsChannel.broadcast_update_to(
      :page,
      target: "status",
      partial: "pages/generating",
    )
  end
end
