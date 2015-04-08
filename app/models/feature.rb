class Feature
  def initialize(url)
    @url = url
    @api_response = api_response
  end

  def avatar_url
    @api_response["owner"]["avatar_url"]
  end

  def description
    @api_response["description"]
  end

  def name
    @api_response["name"]
  end

  def stargazers_count
    @api_response["stargazers_count"]
  end

  private

  def api_response
    api_endpoint = File.join(
      "https://api.github.com/repos",
      "#{@url}?access_token=#{ENV["OAUTH_TOKEN"]}"
    )
    @api_response ||= HTTParty.get(api_endpoint)
  end
end
