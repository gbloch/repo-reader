module ApplicationHelper
  def markdown_to_html
    MarkdownProcessor.new(request).html
  end

  def breadcrumb
    Breadcrumb.new(request.original_url).breadcrumb
  end

  def feature(url)
    Feature.new(url)
  end
end
