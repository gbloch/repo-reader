class Breadcrumb
  def initialize(url)
    @url = url
  end

  def breadcrumb
    breadcrumb = ""
    path_array.each_with_index do |path_segment, index|
      if index < 2
        breadcrumb += "/#{path_segment}"
      else
        path_segment_href = path_segment_href(index)
        breadcrumb += path_segment_anchor(path_segment_href, path_segment)
      end
    end
    breadcrumb
  end

  private

  def path_array
    array = URI::parse(@url).path.split("/")
    array.reject(&:empty?)
  end
  
  def path_segment_href(index)
    path_segment_href = ""
    for i in 0..index
      path_segment_href += "/#{path_array[i]}"
    end
    path_segment_href
  end

  def path_segment_anchor(href, path_segment)
    "<a href='#{href}'>/#{path_segment}</a>"
  end
end
