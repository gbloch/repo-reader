require "rails_helper"

RSpec.describe Url do
  context "with url http://example.com/organization/repository/branch/file" do
    before do
      url = "http://example.com/organization/repository/branch/file"
      @parsed_url = Url.new(url)
    end

    describe "#parsed_sheme" do
      it "returns the scheme" do
        result = @parsed_url.parsed_scheme

        expect(result).to eq "http"
      end
    end

    describe "#parsed_path" do
      it "returns the scheme" do
        result = @parsed_url.parsed_path

        expect(result).to eq "/organization/repository/branch/file"
      end
    end

    describe "#organization" do
      it "returns the git hub organization" do
        result = @parsed_url.organization

        expect(result).to eq "organization"
      end
    end

    describe "#repository" do
      it "returns the git hub repository" do
        result = @parsed_url.repository

        expect(result).to eq "repository"
      end
    end

    describe "#branch" do
      it "returns the repository branch" do
        result = @parsed_url.branch

        expect(result).to eq "branch"
      end
    end
  end

  context "with url http://example.com" do
    before do
      url = "http://example.com"
      @parsed_url = Url.new(url)
    end

    describe "#organization" do
      it "returns the git hub organization" do
        result = @parsed_url.organization

        expect(result).to eq ""
      end
    end

    describe "#repository" do
      it "returns the git hub repository" do
        result = @parsed_url.repository

        expect(result).to eq ""
      end
    end

    describe "#branch" do
      it "returns the repository branch" do
        result = @parsed_url.branch

        expect(result).to eq ""
      end
    end
  end
end
