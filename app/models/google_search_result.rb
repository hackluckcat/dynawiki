# frozen_string_literal: true

require 'net/http'    

class GoogleSearchResult
  class SearchError < StandardError; end

  BASE_URL = "https://www.googleapis.com/customsearch/v1"

  def initialize(
    query:,
    key: ENV["GOOGLE_SEARCH_KEY"],
    cx: ENV["GOOGLE_SEARCH_ENGINE"],
    lang: :en
  )
    @query = query
    @key = key
    @cx = cx
    @lang = lang
  end

  def urls(
    limit: 4,
    exclude: %w[
      apps.apple.com
      youtube
      podcast
      instagram
      x.com
      twitter
    ]
  )
    response = Net::HTTP.get_response(endpoint)
    unless response.is_a?(Net::HTTPSuccess)
      raise SearchError
    end

    result = JSON.parse(response.body)
    result = result["items"].map { _1["link"] }
    result = result.filter do |r|
      uri = URI.parse(r)
      uri.scheme == "https" && !uri.host.match?(/(#{exclude.join("|")})/)
    end
    result = result[..limit]
  end

  private def endpoint
    uri = URI(BASE_URL)
    uri.query = params
    uri
  end

  private def params
    URI.encode_www_form(
      [
        [ "q", @query ],
        [ "key", @key ],
        [ "cx", @cx ],
        [ "lr", "lang_#{@lang}" ]
      ]
    )
  end
end
