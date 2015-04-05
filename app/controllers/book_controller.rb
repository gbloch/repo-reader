class BookController < ApplicationController
  def index
    url = params[:url]
    validated_url = BookUrlValidator.new(url).validate
    redirect_to File.join(validated_url)
  end

  def show
  end
end
