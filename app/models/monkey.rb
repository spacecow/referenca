class Array
  def sort_by_author_first_name_then_year
    sort{|x,y| x.first_author == y.first_author ? y.year <=> x.year : x.first_author <=> y.first_author}
  end

  def public_or_privately_owned(user,assoc=nil)
    reject{|e| e.private_assoc(assoc) && !group_member(e,user,assoc) && !owner(e,user,assoc)}
  end

  def public_or_privately_owned_reference(user)
    public_or_privately_owned(user,:referenced_article)
  end

  def public_or_privately_owned_referenced(user)
    public_or_privately_owned(user,:article)
  end    

  private

  def group_member(e,user,assoc=nil)
    e.group_assoc(assoc) && e.group_assoc(assoc).users.include?(user)
  end

  def owner(e,user,assoc=nil)
    e.owner_assoc(assoc) && e.owner_assoc(assoc) == user
  end
end
