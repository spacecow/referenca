Then /^I should see "([^"]*)" listed (\w+)$/ do |text,order|
  Then %(I should see "#{text}" within "#{link_no(no order)}")
end

Then /^I should see "([^"]*)" unlisted (\w+)$/ do |text,order|
  Then %(I should see "#{text}" within "#{unlink_no(no order)}")
end

When /^I follow "([^"]*)" within the (\w+) listing$/ do |link,order|
  When %(I follow "#{link}" within "#{link_no(no order)}")
end

Then /^I should see a (\w*) listing$/ do |order|
  page.should have_css("li:nth-child(#{no order})")
end
Then /^I should see no (\w*) listing$/ do |order|
  page.should have_no_css("li:nth-child(#{no order})")
end

def link_no(i); "ol li:nth-child(#{i})" end
def unlink_no(i); "ul li:nth-child(#{i})" end
