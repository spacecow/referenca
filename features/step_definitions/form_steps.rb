Then /^"(.*)" should have options "(.*)"$/ do |select_id, options|
  field = find_field(select_id)
  field.native.css("option").to_a.map(&:inner_html).
    map{|e| e.blank? ? "BLANK" : e}.join(", ").should == options
end

Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  field_labeled(field).native.search(".//option[@selected = 'selected']").inner_html.should == value
end

Then /^I should see (?:a|an) (\w+) (\w+) error "([^"]*)"$/ do |mdl,attr,txt|
  page.should have_css("li##{mdl}_#{attr}_input p.inline-errors", :text => txt)
end

Then /^I should see no (\w+) (\w+) error$/ do |mdl,attr|
  page.should have_no_css("li##{mdl}_#{attr}_input p.inline-errors")
end

When /^I check the (\w+) "([^"]*)"$/ do |order,lbl|
  mdl = "authorships" if lbl == "Remove Author"
  mdl = "articles_keywords" if lbl == "Remove Keyword"
  When %(I check "article_#{mdl}_attributes_#{zero_no order}__destroy")
end

When /^I press the submit button$/ do
  find(:css, 'input.submit').click
end
