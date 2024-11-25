class Page < ApplicationRecord
  belongs_to :language
  has_many :references, dependent: :destroy

  def prompt
    <<~MARKDOWN
      You are tasked with creating a Wiki-like summary of information from multiple webpages. The content from these webpages has been combined and will be provided to you. Your goal is to summarize and format this information in a coherent, Wiki-style article.

      Here is the combined content from multiple webpages:

      <webpage_content>
      #{references.map(&:body)}
      </webpage_content>

      Your task is to create a Wiki-like article based on the following topic:

      <topic>#{title}</topic>

      Follow these guidelines to structure your Wiki-like article:

      1. Start with a brief introduction of the topic.
      2. Organize the information into logical sections with appropriate headings.
      3. Use bullet points or numbered lists where appropriate to present information clearly.
      4. Include any relevant historical information, cultural significance, or interesting facts.
      5. If there are conflicting pieces of information from different sources, present the most commonly agreed-upon facts or note the discrepancies.
      6. Summarize the key points, avoiding unnecessary details or repetition.
      7. Use a neutral, informative tone throughout the article.
      8. If specific locations or establishments are mentioned, you may include them in a separate section.

      Do not include any citations or references to specific websites in your output. Present the information as if it's general knowledge in a Wiki format.

      <language>#{language.code}</language>
      <format>Markdown</format>

      Please provide your Wiki-like article within <wiki_article> tags. Begin your response immediately with the opening tag, followed by your formatted article, and end with the closing tag.
    MARKDOWN
  end
end
