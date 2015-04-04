module ApplicationHelper
  def markdown_to_html
    markdown.processed_html
  end

  def markdown
    MarkdownProcessor.new(request)
  end
end
