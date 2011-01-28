Given /^#{capture_model} references #{capture_model}$/ do |main,ref|
  Given %(a reference exists with article: #{main}, referenced_article: #{ref})
end

Given /^#{capture_model} references #{capture_model} & #{capture_model}$/ do |main,ref1,ref2|
  Given %(#{main} references #{ref1})
  And %(#{main} references #{ref2})
end


When /^I select "([^"]*)" as (second) reference$/ do |text,order|
  When %(I select "#{text}" from "article_references_attributes_1_referenced_article_id")
end

Then /^I should see a (\w*) reference$/ do |order|
  page.should have_css("#{select_field order}")
end

Then /^I should see a (\w+) reference with no: (\d+)$/ do |order,no|
  with_scope("#{li_field(order,'no')}") do
    find_field("No").value.should eq no
  end
end



Then /^I should see no (\w*) reference$/ do |order|
  page.should have_no_css("select##{select_id(zero_no order)}")
end

Then /^I should see a "([^"]*)" error "([^"]*)" on the (\w+) reference$/ do |field,text,order|
  with_scope("#{error_path(zero_no(order),field.downcase)}") do
    page.should have_content(text)
  end
end


def select_field(i); "select##{select_id(zero_no i)}" end
def select_id(i); "article_references_attributes_#{i}_referenced_article_id" end
def li_field(i,field); "li##{li_id(i,field)}" end
def li_id(i,field); "article_references_attributes_#{zero_no i}_#{field}_input" end
def error_field; "p.#{error_id}" end
def error_id; "inline-errors" end
def error_path(i,field); "#{li_field(i,field)} #{error_field}" end
