require "rails_helper"

RSpec.describe RepositoryUrlValidator do
  describe "#validate" do
    it "returns a valid url to a repository" do
      url_one = "org/repo"
      url_two = "/org/repo"
      url_three = "org/repo/branch"
      url_four = "/org/repo/branch"

      result_one = RepositoryUrlValidator.new(url_one).validate
      result_two = RepositoryUrlValidator.new(url_two).validate
      result_three = RepositoryUrlValidator.new(url_three).validate
      result_four = RepositoryUrlValidator.new(url_four).validate

      expect(result_one).to eq "/org/repo/master"
      expect(result_two).to eq "/org/repo/master"
      expect(result_three).to eq "/org/repo/branch"
      expect(result_four).to eq "/org/repo/branch"
    end
  end
end
