class Feature
  include ActionView::Helpers::NumberHelper

  def initialize(url)
    @api_response = ApiCall.api_response(url)
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
end
