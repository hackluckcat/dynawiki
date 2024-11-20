require "test_helper"

class PageReferenceSearchTest < ActiveSupport::TestCase
  test "#url" do
    assert(
      "https://www.googleapis.com/customsearch/v1?q=Dog&key=xxx&cx=yyy",
      PageReferenceSearch.new(page: pages(:Dog), key: "xxx", cx: "yyy").url
    )
  end
end
