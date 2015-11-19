class ApiCall
  GITHUB_SEARCH_ENDPOINT = "https://api.github.com/search/repositories"
  GITHUB_REPOS_ENDPOINT = "https://api.github.com/repos"

  def self.api_response(url)
    HTTParty.get(api_repos_endpoint(url))
  end

  def self.api_repos_endpoint(url)
    File.join(GITHUB_REPOS_ENDPOINT, "#{url}#{url_param}")
  end

  def self.api_search_response(criteria)
    HTTParty.get(api_search_endpoint(criteria))
  end

  def self.api_search_endpoint(criteria)
    File.join("#{GITHUB_SEARCH_ENDPOINT}?#{criteria}#{url_param}")
  end

  def self.url_param
    "&access_token=#{ENV["OAUTH_TOKEN"]}"
  end
end
