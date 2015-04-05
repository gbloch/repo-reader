require "rails_helper"

RSpec.describe Link do
  before do
    @base_url = "/org/repo/branch"
  end

  describe "#absolute_path" do
    it "returns the absolute path" do
      original_url = "#{ENV["BASE_PATH"]}/org/repo/branch/README.md"
      href_one = "https://example.com/directory/file.png"
      href_two = "directory/file.png"

      link_one = Link.new(href_one, original_url)
      link_two = Link.new(href_two, original_url)

      result_one = link_one.absolute_path
      result_two = link_two.absolute_path

      expect(result_one).to eq "https://example.com/directory/file.png"
      expect(result_two).to eq "#{ENV["BASE_PATH"]}/org/repo/branch/directory/file.png"
    end
  end

  describe "#parsed_href" do
    context "is absolute" do
      it "returns the same path" do
        href = "http://example.com"
        link = Link.new(href, original_url: "")

        result = link.parsed_href

        expect(result).to eq href
      end
    end

    context "is relative to document root" do
      it "returns the absolute path to branch/href" do
        original_url = "#{@base_url}/file"
        href = "/file/file"
        link = Link.new(href, original_url)

        result = link.parsed_href

        expect(result).to eq "#{@base_url}/file/file"
      end
    end

    context "is relative to document" do
      it "returns the base path to original_url/href" do
        original_url = "#{@base_url}/file"
        href = "file/file"
        link = Link.new(href, original_url)

        result = link.parsed_href

        expect(result).to eq "#{@base_url}/file/file/file"
      end
    end
  end
end
