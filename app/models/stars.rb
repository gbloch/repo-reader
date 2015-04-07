class Stars
  def initialize(url)
    @url = url
  end

  def stargazers_count
    api_endpoint = File.join("https://api.github.com/repos", @url)
    response = HTTParty.get(api_endpoint)
    response["stargazers_count"]
  end
end
