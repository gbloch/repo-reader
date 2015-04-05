module ApplicationHelper
  def markdown_to_html
    MarkdownProcessor.new(request).processed_html
  end

  def breadcrumb
    Breadcrumb.new(request.original_url).breadcrumb
  end
end
