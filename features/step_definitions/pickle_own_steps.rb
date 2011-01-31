Given /^#{capture_model} is one of #{capture_model}'s (\w+)$/ do |owned, owner, assoc|
  model!(owner).send(assoc) << model!(owned)
end

Given /^#{capture_model} is one of #{capture_model} & #{capture_model}'s (\w+)$/ do |owned, owner1, owner2, assoc|
  Given %(#{owned} is one of #{owner1}'s #{assoc})
  And %(#{owned} is one of #{owner2}'s #{assoc})  
end

Given(/^#{capture_model} exists?(?: with #{capture_fields})?$/) do |name, fields|
  mdl = create_model(name, fields)
  if mdl.class == User
    mdl.groups << Group.new(:title => mdl.username)
  end
end

Given(/^#{capture_model} exists with(?: #{capture_fields} and)? group "([^"]*)"$/) do |name,fields,group|
  mdl = create_model(name,fields)
  if mdl.class == User
    Given %(a group "#{group}" exists with title: "#{mdl.username}")
    mdl.groups << model("group \"#{group}\"")
  end
end
