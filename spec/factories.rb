Factory.define :article do |f|
  f.sequence(:title){|n| "Default article name #{n}"}
  f.year "2000"
end

Factory.define :author do |f|
  f.sequence(:first_name){|n| "Default first name #{n}"}
  f.sequence(:last_name){|n| "Default last name #{n}"}  
end

Factory.define :reference do |f|
  f.sequence(:no){|n| n}
end
