require "rails_helper"

RSpec.describe RemoteFileValidator do
  describe "#remote_file" do
    context "there is a valid remote file" do
      it "returns a valid remote file" do
        stub_request_with_path("readme.md", [200, "Okay"])
        request = double("request")
        request.stub(:original_url)
          .and_return("https://raw.githubusercontent.com/readme.md")

        response = RemoteFileValidator.new(request)

        expect(response.remote_file.status[0]).to eq "200"
      end
    end

    context "there is not a valid remote file" do
      it "returns a valid remote file" do
        stub_request_with_path("readme.md", [404, "Not Found"])
        request = double("request")
        request.stub(:original_url)
          .and_return("https://raw.githubusercontent.com/readme.md")

        response = RemoteFileValidator.new(request)

        expect(response.remote_file).to eq "404 Not Found"
      end
    end

    context "there is a valid remote file named readme.markdown" do
      it "tries all of the potential file paths" do
        stub_request_with_path("README.md", [404, "Not Found"])
        stub_request_with_path("readme.md", [404, "Not Found"])
        stub_request_with_path("Readme.md", [404, "Not Found"])
        stub_request_with_path("readme.markdown", [200, "Okay"])
        request = double("request")
        request.stub(:original_url)
          .and_return("https://raw.githubusercontent.com/")

        response = RemoteFileValidator.new(request)
        remote_file = response.remote_file

        expect(remote_file.status[0]).to eq "200"
      end
    end
  end

  describe "#remote_file_path" do
    context "is a directory" do
      it "returns a full path to the README.md" do
        stub_request_with_path("directory", [200, "Okay"])
        request = double("request")
        request.stub(:original_url)
          .and_return("https://raw.githubusercontent.com/directory")
        remote_file_path = RemoteFileValidator.new(request).remote_file_path

        expect(remote_file_path).to eq "https://raw.githubusercontent.com/directory/README.md"
      end
    end

    context "is a file" do
      it "returns a full path to the somefile.md" do
        stub_request_with_path("somefile.md", [200, "Okay"])
        request = double("request")
        request.stub(:original_url).and_return("https://raw.githubusercontent.com/somefile.md")
        remote_file_path = RemoteFileValidator.new(request).remote_file_path

        expect(remote_file_path).to eq "https://raw.githubusercontent.com/somefile.md"
      end
    end
  end

  def stub_request_with_path(path, status)
    stub_request(:get, "https://raw.githubusercontent.com/#{path}").
      to_return(status: status, body: "Hello world!", headers: {})
  end
end
