class Feature
  def initialize(url)
    @url = url
  end

  def description
    api_response["description"]
  end

  def name
    api_response["name"]
  end

  def stargazers_count
    api_response["stargazers_count"]
  end

  private

  def api_response
    api_endpoint = File.join("https://api.github.com/repos", @url)
    HTTParty.get(api_endpoint)
  end
end
