require "rails_helper"

RSpec.describe MarkdownProcessor do
  describe "#html" do
    context "with a file" do
      it "returns processed markdown" do
        request = stub_request_with_path("readme.md", [200, "Okay"])

        response = MarkdownProcessor.new(request).html

        expect(response).to include "Hello world!"
      end
    end
  end

  def stub_request_with_path(path, status)
    stub_request(:get, "https://raw.githubusercontent.com/#{path}").
      to_return(status: status, body: "Hello world!", headers: {})
      request = double("request")
      request.stub(:original_url)
        .and_return("https://raw.githubusercontent.com/readme.md")
      request
  end
end
