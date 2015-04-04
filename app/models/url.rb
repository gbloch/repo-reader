class Url
  def initialize(url)
    @url = url
  end

  def parsed_scheme
    parsed_url.scheme
  end

  def parsed_path
    parsed_url.path
  end

  def organization
    parsed_path_array[1]
  end

  def repository
    parsed_path_array[2]
  end

  def branch
    parsed_path_array[3]
  end

  private

  def parsed_url
    URI::parse(@url)
  end

  def parsed_path_array
    parsed_path.split("/")
  end
end
