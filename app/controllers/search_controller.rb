class SearchController < ApplicationController
  def index
    @repositories = []
  end

  def search
    @repositories = repositories(params[:repo])

    render "index"
  end

  def repositories(param_name)
    ApiCall.api_search_response("q=#{param_name}+in:name")["items"]
  end
end
