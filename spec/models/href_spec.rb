require "rails_helper"

RSpec.describe Href do
  describe "#path" do
    it "returns the href path" do
      href = "http://example.com/this/that"
      parsed_href = Href.new(href)

      result = parsed_href.path

      expect(result).to be href
    end
  end

  describe "#absolute?" do
    it "returns true if the path is absolute" do
      href = "http://example.com"
      parsed_href = Href.new(href)

      result = parsed_href.absolute?

      expect(result).to be true
    end
  end

  describe "#relative_to_document?" do
    it "returns true if the path is relative to itself" do
      href = "samedirectory/document"
      parsed_href = Href.new(href)

      result = parsed_href.relative_to_document?

      expect(result).to be true
    end
  end

  describe "#relative_to_document_root?" do
    it "returns true if the path is relative to the document root" do
      href = "/document"
      parsed_href = Href.new(href)

      result = parsed_href.relative_to_document_root?

      expect(result).to be true
    end
  end
end
