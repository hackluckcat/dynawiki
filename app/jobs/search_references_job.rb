# frozen_string_literal: true

require "open-uri"

class SearchReferencesJob < ApplicationJob
  include ActionView::RecordIdentifier

  queue_as :default

  def perform(page_id:)
    page = Page.find(page_id)
    urls = GoogleSearchResult.new(query: page.title, lang: page.language.code).urls
    page.references.destroy_all
    urls[..3].each do |url|
      html_content = URI.open(url)
      reference = Reference.from_html(html_content:, url:)
      page.references << reference
      Turbo::StreamsChannel.broadcast_append_to(
        dom_id(page),
        target: "references",
        partial: "references/item",
        locals: { reference: }
      )
    rescue => e
      logger.error e
    end
    llm = Anthropic::Client.new(
      access_token: ENV["ANTHROPIC_API_KEY"],
      anthropic_version: "2023-06-01",
    ) do |f|
      f.response :logger, Logger.new($stdout), bodies: true
    end
    llm.messages(
      parameters: {
        model: "claude-3-5-sonnet-20241022",
        messages: [ { role: "user", content: page.prompt } ],
        max_tokens: 4096,
        stream: Proc.new do |chunk|
          new_content = chunk.dig("delta", "text")
          unless new_content
            next
          end
          page.update(body: "#{page.body}#{new_content}")

          Turbo::StreamsChannel.broadcast_update_to(
            dom_id(page),
            partial: "pages/body",
            locals: { body: page.body },
            target: "body"
          )
        end
      }
    )
  end
end
