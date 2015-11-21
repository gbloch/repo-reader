class RemoteFileValidator
  require "open-uri"
  require "uri"

  README_VARIATIONS = [
    "README.md",
    "readme.md",
    "Readme.md",
    "readme.markdown"
  ]

  def initialize(request)
    @request = request
    @index = 0
  end

  def remote_file
    begin
      open(remote_file_path)
    rescue OpenURI::HTTPError => error
      if error.message == "404 Not Found" and @index <= README_VARIATIONS.count
        @index += 1
        remote_file
      else
        error.message
      end
    end
  end

  def remote_file_path
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
    query_params["url"].first || README_VARIATIONS[@index]
  end

  def query_params
    CGI::parse(querystring)
  end

  def querystring
    parsed_original_url.query || ""
  end

  def parsed_original_url
    URI::parse(URI::encode(@request.original_url))
  end
end
