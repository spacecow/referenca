module ArticlesHelper
  def attribute(attr,fallback)
    return fallback if attr.nil?
    attr.empty? ? fallback : attr
  end
end
