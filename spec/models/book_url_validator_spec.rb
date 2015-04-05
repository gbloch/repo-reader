require "rails_helper"

RSpec.describe BookUrlValidator do
  describe "#validate" do
    it "returns a valid url to a repository" do
      url_one = "org/repo"
      url_two = "/org/repo"
      url_three = "org/repo/branch"
      url_four = "/org/repo/branch"

      result_one = BookUrlValidator.new(url_one).validate
      result_two = BookUrlValidator.new(url_two).validate
      result_three = BookUrlValidator.new(url_three).validate
      result_four = BookUrlValidator.new(url_four).validate

      expect(result_one).to eq "/org/repo/master"
      expect(result_two).to eq "/org/repo/master"
      expect(result_three).to eq "/org/repo/branch"
      expect(result_four).to eq "/org/repo/branch"
    end
  end
end
