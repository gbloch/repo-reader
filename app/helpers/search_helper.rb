module SearchHelper
  def has_results_class
    if has_results?
      "results"
    else
      "no-results"
    end
  end

  def has_results?
    if @repositories.empty?
      false
    else
      true
    end
  end
end
