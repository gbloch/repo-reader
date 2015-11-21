class MarkdownProcessor
  require "cgi"
  require "kramdown"

  attr_reader :request

  def initialize(request)
    @index = 0
    @request = request
    @remote_file = RemoteFileValidator.new(@request).remote_file
  end

  def html
    document = Nokogiri::HTML(kramdown_html)
    update_images_in_document(document)
    update_links_in_document(document)
    document.to_html
  end

  private

  def kramdown_html
    Kramdown::Document.new(remote_file_body).to_html
  end

  def remote_file_body
    unless @remote_file.nil? || @remote_file.is_a?(String)
      @remote_file.read
    else
      @remote_file
    end
  end

  def update_images_in_document(document)
    document.css("img").each do |link|
      src = link["src"]
      new_src = Link.new(src, @request.original_url).absolute_path

      link["src"] = new_src
    end
  end

  def update_links_in_document(document)
    document.css("a").each do |link|
      href = link["href"]
      new_href = Link.new(href, @request.original_url).parsed_href

      link["href"] = new_href
    end
  end
end
