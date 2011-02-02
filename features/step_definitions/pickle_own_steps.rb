Given /^#{capture_model} is one of #{capture_model}'s (\w+)$/ do |owned, owner, assoc|
  model!(owner).send(assoc) << model!(owned)
end

Given /^#{capture_model} is one of #{capture_model} & #{capture_model}'s (\w+)$/ do |owned, owner1, owner2, assoc|
  Given %(#{owned} is one of #{owner1}'s #{assoc})
  And %(#{owned} is one of #{owner2}'s #{assoc})  
end

Given(/^#{capture_model} exists with (?: username: "([^"]*)" and)?group "([^"]*)"$/) do |name,field,group|
  Given %(a group "#{group}" exists with title: "#{group}") unless (name =~ /user/).nil?
  mdl = create_model(name,"username: \"#{group}\"")
  mdl.groups << model("group \"#{group}\"")
end

