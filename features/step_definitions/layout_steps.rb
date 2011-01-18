Then /^I should see (?:a|an) "([^"]*)" section$/ do |section|
  page.should have_css("div##{section.downcase.gsub(/\s/,'_')}")
end

Then /^I should see no "([^"]*)" section$/ do |section|
  page.should have_no_css("div##{section.downcase.gsub(/\s/,'_')}")
end
