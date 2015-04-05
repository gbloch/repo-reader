require "cgi"
require "kramdown"
require "open-uri"
require "pry"
require "uri"

class MarkdownProcessor
  attr_reader :request

  BASE = "https://raw.githubusercontent.com/"

  def initialize(request)
    @request = request
  end

  def processed_html
    doc = Nokogiri::HTML(html)
    doc.css("a").each do |link|
      href = link["href"]
      new_href = Link.new(href, @request.original_url).parsed_href

      link["href"] = new_href
    end
    doc
  end

  private

  def html
    Kramdown::Document.new(unprocessed_markdown).to_html
  end

  def unprocessed_markdown
    open(unprocessed_markdown_file).read
  end

  def unprocessed_markdown_file
    if path_to_file then path_to_file else path_to_directory end
  end

  def path_to_file
    if File.extname(parsed_original_url.path).present?
      git_raw_path
    end
  end

  def path_to_directory
    File.join(git_raw_path, query_url)
  end

  def git_raw_path
    File.join(ENV["BASE_PATH"], local_path)
  end

  def local_path
    parsed_original_url.path
  end

  def query_url
    query_params["url"].first || "README.md"
  end

  def query_params
    CGI::parse(querystring)
  end

  def querystring
    parsed_original_url.query || ""
  end

  def parsed_original_url
    URI::parse(request.original_url)
  end
end
