class Href
  def initialize(href)
    @href = href
  end

  def path
    @href
  end

  def relative_to_document?
    @href[0] != "/" && !absolute?
  end

  def absolute?
    %w( http https ).include?(parsed_scheme)
  end

  def relative_to_document_root?
    @href[0] == "/"
  end

  private

  def parsed_scheme
    URI::parse(@href).scheme
  end
end
