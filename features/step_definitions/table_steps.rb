Then /^I should see "([^"]*)" within the (\w+) table row$/ do |txt,order|
  page.should have_css("table tr:nth-child(#{no order})", :text => txt)
end

Then /^I should not see "([^"]*)" within the (\w+) table row$/ do |txt,order|
  page.should have_no_css("table tr:nth-child(#{no order})", :text => txt)
end

Then /^I should see a (\w*) row$/ do |order|
  page.should have_css("tr:nth-child(#{no order})")
end
Then /^I should see no (\w*) row$/ do |order|
  page.should have_no_css("tr:nth-child(#{no order})")
end

When /^I follow "([^"]*)" within the (\w+) table row$/ do |link,order|
  When %(I follow "#{link}" within "table tr:nth-child(#{no order})")
end

Then /^I should see a link "([^"]*)" within the (\w+) table row$/ do |txt,order|
  page.should have_css("tr:nth-child(#{no order}) a", :text => txt)
end

Then /^I should see no link "([^"]*)" within the (\w+) table row$/ do |txt,order|
  page.should have_no_css("tr:nth-child(#{no order}) a", :text => txt)
end
