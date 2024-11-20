class PageReferenceSearch
  BASE_URL = "https://www.googleapis.com/customsearch/v1"

  def initialize(
    page:,
    key: ENV["GOOGLE_SEARCH_KEY"],
    cx: ENV["GOOGLE_SEARCH_ENGINE"]
  )
    @page = page
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
        [ "q", CGI.escape(@page.title) ],
        [ "key", @key ],
        [ "cx", @engine ]
      ]
    )
  end
end
