class Link
  def initialize(href, original_url)
    @href = Href.new(href)
    @url = Url.new(original_url) 
  end

  def parsed_href
    absolute || relative_to_document || relative_to_document_root
  end

  private

  def absolute
    if @href.absolute?
      @href.path
    end
  end

  def relative_to_document
    if @href.relative_to_document?
      File.join(@url.parsed_path, @href.path)
    end
  end

  def relative_to_document_root
    if @href.relative_to_document_root?
      File.join(path_to_branch, @href.path) 
    end
  end

  def path_to_branch
    File.join( "/", @url.organization, @url.repository, @url.branch)
  end
end
