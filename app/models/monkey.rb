class Array
  def sort_by_author_first_name_then_year
    sort{|x,y| x.first_author == y.first_author ? y.year <=> x.year : x.first_author <=> y.first_author}
  end

  def public_or_privately_owned(user,assoc=nil)
    return reject{|e| e.private && !e.users.include?(user)} if assoc==nil
    reject{|e| e.send(assoc).private && !e.send(assoc).users.include?(user)}
  end

  def public_or_privately_owned_reference(user)
    public_or_privately_owned(user,:referenced_article)
  end

  def public_or_privately_owned_referenced(user)
    public_or_privately_owned(user,:article)
  end    
end
