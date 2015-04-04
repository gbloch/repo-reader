require "rails_helper"

RSpec.describe Link do
  before do
    @base_url = "https://raw.githubusercontent.com/org/repo/branch"
  end

  describe "#parsed_href" do
    context "is absolute" do
      it "returns the same path" do
        href = "http://newexample.com"
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

        expect(result).to eq "/org/repo/branch/file/file"
      end
    end

    context "is relative to document" do
      it "returns the base path to original_url/href" do
        original_url = "#{@base_url}/file"
        href = "file/file"
        link = Link.new(href, original_url)

        result = link.parsed_href

        expect(result).to eq "/org/repo/branch/file/file/file"
      end
    end
  end
end
