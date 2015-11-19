class Feature
  include ActionView::Helpers::NumberHelper

  def initialize(url)
    @api_response = api_response(url)
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

  def repository_path
    "#{@api_response["owner"]}/#{@api_response["name"]}"
  end

  def stargazers_count
    count = @api_response["stargazers_count"].to_i

    number_with_delimiter(count, delimiter: ",")
  end

  private

  def api_response(url)
    @api_response ||= HTTParty.get(api_endpoint(url))
  end

  def api_endpoint(url)
    File.join(github_url, "#{url}#{url_param}")
  end

  def github_url
    "https://api.github.com/repos"
  end

  def url_param
    "?access_token=#{ENV["OAUTH_TOKEN"]}"
  end
end
