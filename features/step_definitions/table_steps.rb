Then /^the table's (\w+) row should contain "([^"]*)"$/ do |order,text|
  with_scope("table tr:nth-child(#{no order})") do
    page.should have_content(text)
  end
end

Then /^I should see a (\w*) row$/ do |order|
  page.should have_css("tr:nth-child(#{no order})")
end
Then /^I should see no (\w*) row$/ do |order|
  page.should have_no_css("tr:nth-child(#{no order})")
end
