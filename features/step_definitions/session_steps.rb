Given /^I am logged in as #{capture_model}$/ do |mdl|
  user = model(mdl)
  Given %(I go to the login page)
  And %(I fill in "Username" with "#{user.username}")
  And %(I fill in "Password" with "secret")
  And %(I press "Log in")
end

Given /^I am logged in as "([^"]*)"$/ do |name|
  Given %(a user exists with username: "#{name}")
  And %(I am logged in as that user)
end

