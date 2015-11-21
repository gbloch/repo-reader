class RepositoryUrlValidator
  def initialize(url)
    @url = url
  end

  def validate
    make_relative
    add_branch
    @url
  end

  private

  def make_relative
    if relative?
      @url = File.join("/", @url)
    end
  end

  def add_branch
    if branch?
      @url = File.join(@url, "master")
    end
  end

  def relative?
    @url[0] != "/"
  end

  def branch?
    path_array.length < 3
  end

  def path_array
    path_array = URI::parse(@url).path.split("/")
    path_array.reject!(&:empty?)
  end
end
