class Reference < ApplicationRecord
  belongs_to :page

  def self.from_html(html_content:, url:)
    doc = Nokogiri::HTML(html_content)
    doc.search("script, style, noscript").remove
    body = doc.text.strip
    body = body.gsub(/\s+/, " ")
    body = body.gsub(/\n\s*\n/, "\n")
    title = doc.at("title").text
    uri = URI.parse(url)
    base_url = "#{uri.scheme}://#{uri.host}"
    icon = doc.at('[rel="icon"]')
    image_url = icon ? "#{base_url}#{icon["href"]}" : ""
    new(title:, body:, url:, base_url:, image_url:)
  end
end
