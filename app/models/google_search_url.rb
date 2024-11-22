class GoogleSearchUrl
  BASE_URL = "https://www.googleapis.com/customsearch/v1"

  def initialize(
    query:,
    key: ENV["GOOGLE_SEARCH_KEY"],
    cx: ENV["GOOGLE_SEARCH_ENGINE"]
  )
    @query = query
    @key = key
    @cx = cx
  end

  def url
    uri = URI(BASE_URL)
    uri.query = query
    uri
  end

  private def query
    URI.encode_www_form(
      [
        [ "q", CGI.escape(@query) ],
        [ "key", @key ],
        [ "cx", @cx ]
      ]
    )
  end
end
