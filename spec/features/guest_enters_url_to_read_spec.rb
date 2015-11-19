require "rails_helper"

RSpec.xdescribe "Guest enters url to read" do
  before do
    stub_request(:any, %r{https://api.github.com/.*})
  end

  it "and is redirected to the book view of that repo" do
    file_name = "file.md"
    create_temp_markdown(file_name)
    stub_request_to_file(file_name)

    visit root_path
    fill_in "repo", with: "org/repo/branch"
    click_button("search_submit")

    expect(page).to have_content "Hi"
  end

  private

  def create_temp_markdown(file_name)
    File.open("/tmp/#{file_name}", "w") do |file|
      file.puts "# Hi"
    end
  end

  def stub_request_to_file(file_name)
    path = "#{ENV["BASE_PATH"]}/org/repo/branch/README.md"
    stub_request(:any, path)
      .to_return(body: File.new("/tmp/#{file_name}"))
  end
end

