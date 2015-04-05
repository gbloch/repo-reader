require "rails_helper"

RSpec.describe "Guest reads article" do
  it "and sees the correct html and links" do
    file_name = "file_one.md"
    create_temp_markdown(file_name)
    stub_request_to_file(file_name)

    visit root_path

    expect(page).to have_content "Hi"
    expect(page).to have_css "a[href='http://www.example.com']"
    expect(page).to have_css "a[href='/directory/file']"
    expect(page).to have_css "a[href='/file']"
    expect(page).to have_css "img[src='#{ENV["BASE_PATH"]}/images/image.png']"
  end

  private

  def create_temp_markdown(file_name)
    File.open("/tmp/#{file_name}", "w") do |file| 
      file.puts "# Hi" 
      file.puts "[link](http://www.example.com)" 
      file.puts "[link](directory/file)" 
      file.puts "[link](/file)" 
      file.puts "![image](/images/image.png 'Alt')"
    end
  end

  def stub_request_to_file(file_name)
    stub_request(:any, "https://raw.githubusercontent.com/README.md")
      .to_return(body: File.new("/tmp/#{file_name}"))
  end
end
