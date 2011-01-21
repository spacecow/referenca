class Array
  def sort_by_author_first_name_then_year
    sort{|x,y| x.first_author == y.first_author ? y.year <=> x.year : x.first_author <=> y.first_author}
  end
end
