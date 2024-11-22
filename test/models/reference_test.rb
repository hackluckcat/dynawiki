require "test_helper"

class ReferenceTest < ActiveSupport::TestCase
  test ".from_html" do
    html_content = <<~HTML
      <html>
        <head>
          <title>Example</title>
          <link rel="icon" href="/icon.png" />
        </head>
        <body>
          This is example page.
        </body>
      </html>
    HTML

    reference = Reference.from_html(html_content:, url: "https://example.com/example")
    assert_equal "https://example.com/example", reference.url
    assert_equal "https://example.com", reference.base_url
    assert_equal "Example", reference.title
    assert_equal "https://example.com/icon.png", reference.image_url
    assert_equal "Example This is example page.", reference.body
  end
end
