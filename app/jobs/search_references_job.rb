class SearchReferencesJob < ApplicationJob
  queue_as :default

  def perform(query:)
    urls = GoogleSearchResult.new(query:).urls
    Turbo::StreamsChannel.broadcast_update_to(
      :page,
      target: "status",
      partial: "pages/loading",
    )
  end
end
