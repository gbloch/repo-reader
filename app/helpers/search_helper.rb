module SearchHelper
  def search_wrapper_class
    if @repositories.empty?
      "no-results"
    end
  end
end
