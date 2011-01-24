Then /^I should see (?:a|an) "([^"]*)" section$/ do |section|
  page.should have_css("div##{section.downcase.gsub(/\s/,'_')}")
end

Then /^I should see no "([^"]*)" section$/ do |section|
  page.should have_no_css("div##{section.downcase.gsub(/\s/,'_')}")
end

Then /^I should see "([^"]*)" as (\w+) flash message$/ do |txt,cat|
  with_scope("div#flash_#{cat}"){ page.text.should eq txt }
end

Then /^I should see no "([^"]*)" as (\w+) flash message$/ do |txt,cat|
  page.should have_no_css("div#flash_#{cat}")
end

Then /^I should see "([^"]*)" as title$/ do |txt|
  with_scope("h1"){ page.text.should eq txt }
end

When /^I follow "([^"]*)" at the bottom of the page$/ do |link|
  When %(I follow "#{link}" within "div#bottom_links")
end

Then /^I should see no link "([^"]*)" at the bottom of the page$/ do |txt|
  page.should have_no_css("div#bottom_links a", :text => txt)
end
