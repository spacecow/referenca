Factory.define :article do |f|
  f.sequence(:title){|n| "Default article name #{n}"}
  f.year "2000"
  f.association :owner, :factory => :user
  f.private false
  f.association :group, :factory => :group
end

Factory.define :author do |f|
  f.sequence(:first_name){|n| "Default first name #{n}"}
  f.sequence(:last_name){|n| "Default last name #{n}"}  
end

Factory.define :group do |f|
  f.sequence(:title){|n| "Default group title #{n}"}
end

Factory.define :keyword do |f|
  f.name "Default keyword"
end

Factory.define :membership do |f|
  f.roles_mask 1
end

Factory.define :reference do |f|
  f.sequence(:no){|n| n}
end

Factory.define :user do |f|
  f.sequence(:username){|n| "user #{n}"}
  f.sequence(:email){|n| "test#{n}@example.com"}
  f.password "secret"
end

