class Feature
  include ActionView::Helpers::NumberHelper

  def initialize(url)
    @url = url
    @api_response = api_response
  end

  def avatar_url
    if @api_response["owner"]
      @api_response["owner"]["avatar_url"]
    end
  end

  def description
    @api_response["description"]
  end

  def name
    @api_response["name"]
  end

  def stargazers_count
    count = @api_response["stargazers_count"].to_i
    number_with_delimiter(count, delimiter: ",")
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
