require "rails_helper"

RSpec.describe Feature do
  before do
    stub_request(:any, %r{https://api.github.com/.*}).to_return(json_response)
    @feature = Feature.new("https://api.github.com/repo")
  end

  describe "#description" do
    it "returns the description of the repository" do
      description = @feature.description
      expect(description).to eq "This is the description."
    end
  end

  describe "#name" do
    it "returns the name of the repository" do
      name = @feature.name
      expect(name).to eq "Name"
    end
  end

  describe "#stargazers_count" do
    it "returns the number of stargazers for the repository" do
      stargazers_count = @feature.stargazers_count
      expect(stargazers_count).to eq 99
    end
  end

  describe "#avatar_url" do
    it "returns the avatar url of the owner of the repository" do
      avatar_url = @feature.avatar_url
      expect(avatar_url).to eq "https://example.com/image"
    end
  end

  private

  def json_response
    { body: json_file, headers: { content_type: "application/json" } }
  end

  def json_file
    json = {
      description: "This is the description.",
      name: "Name",
      stargazers_count: 99,
      owner: {
        avatar_url: "https://example.com/image"
      }
    }
    json.to_json
  end
end
