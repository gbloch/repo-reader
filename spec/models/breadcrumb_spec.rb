require "rails_helper"

RSpec.describe Breadcrumb do
  describe "#breadcrumb" do
    it "parses the current url into a series of links" do
      url = "http://www.example.com/org/repo/branch/directory/file"
      result = Breadcrumb.new(url).breadcrumb

      href_branch = "<a href='/org/repo/branch'>/branch</a>"
      href_directory = "<a href='/org/repo/branch/directory'>/directory</a>"
      href_file = "<a href='/org/repo/branch/directory/file'>/file</a>"
      
      expect(result).to eq "/org/repo#{href_branch}#{href_directory}#{href_file}"
    end
  end
end
