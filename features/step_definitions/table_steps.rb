Then /^I should see "([^"]*)" within the (\w+) table row$/ do |txt,order|
  page.should have_css("#{table_row(order)}", :text => txt)
end

Then /^I should not see "([^"]*)" within the (\w+) table row$/ do |txt,order|
  page.should have_no_css("#{table_row(order)}", :text => txt)
end

Then /^I should see a (\w*) row$/ do |order|
  page.should have_css("#{table_row(order)}")
end
Then /^I should see no (\w*) row$/ do |order|
  page.should have_no_css("#{table_row(order)}")
end

When /^I follow "([^"]*)" within the (\w+) table row$/ do |link,order|
  When %(I follow "#{link}" within "#{table_row(order)}")
end
When /^I click the (\w+) image within the (\w+) table row$/ do |ext,order|
  find(:xpath, "//tr[position()=#{no order}]/td/a/img[@alt = '#{ext}']/parent::a").click
end


Then /^I should see a link "([^"]*)" within the (\w+) table row$/ do |txt,order|
  page.should have_css("#{table_row(order)} a", :text => txt)
end

Then /^I should see no link "([^"]*)" within the (\w+) table row$/ do |txt,order|
  page.should have_no_css("#{table_row(order)} a", :text => txt)
end

Then /^I should see a (pdf|chm) image within the (\w+) table row$/ do |ext,order|
  Then %(I should see a #{ext} image within "#{table_row(order)} img")
end

def table_row(order); "table tr:nth-child(#{no order})" end
