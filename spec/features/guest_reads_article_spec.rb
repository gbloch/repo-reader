require "rails_helper"

RSpec.describe "Guest reads article" do
  it "and sees the correct html and links" do
    file_name = "file_one.md"
    create_temp_markdown(file_name)
    stub_request_to_file(file_name)

    visit "/org/repo/branch"

    expect(page).to have_content "Hi"
    expect(page).to have_css "a[href='http://www.example.com']"
    expect(page).to have_css "a[href='/org/repo/branch/directory/file']"
    expect(page).to have_css "a[href='/org/repo/branch/file']"
    expect(page).to have_css "img[src='#{ENV["BASE_PATH"]}/org/repo/branch/image.png']"
  end

  private

  def create_temp_markdown(file_name)
    File.open("/tmp/#{file_name}", "w") do |file| 
      file.puts "# Hi" 
      file.puts "[link](http://www.example.com)" 
      file.puts "[link](directory/file)" 
      file.puts "[link](/file)" 
      file.puts "![image](/image.png 'Alt')"
    end
  end

  def stub_request_to_file(file_name)
    path = "#{ENV["BASE_PATH"]}/org/repo/branch/README.md"
    stub_request(:any, path)
      .to_return(body: File.new("/tmp/#{file_name}"))
  end
end
