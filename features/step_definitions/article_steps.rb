Then /^#{capture_model} should have a pdf with filename: "([^"]*)"$/ do |mdl,file|
  model(mdl).pdf.filename.should eq file
end

Then /^I select "([^"]*)" as (\w+) author$/ do |text,order|
  id = "article_authorships_attributes_#{zero_no order}_author_id"
  When %(I select "#{text}" from "#{id}")
end

When /^I select "([^"]*)" as (\w+) keyword$/ do |text,order|
  id = "article_articles_keywords_attributes_#{zero_no order}_keyword_id"
  When %(I select "#{text}" from "#{id}")
end


Then /^a file named: "([^"]*)" should exist for #{capture_model}$/ do |file,mdl|
  path = "private/uploads/article/pdf/#{model(mdl).id}/"
  File.open(path+file).should be_true
end

Then /^a file named: "([^"]*)" should not exist for #{capture_model}$/ do |file,mdl|
  path = "private/uploads/article/pdf/#{model(mdl).id}/"
  begin
    File.open(path+file)
    false.should be_true
  rescue Errno::ENOENT
    true.should be_true
  end
end

Given /^I have uploaded "([^"]*)" to #{capture_model}$/ do |file,mdl|
  Given %(I go to #{mdl}'s edit page)
  And %(I attach the file "#{file}" to "PDF")
  And %(I press "Update Private Fields")
end

Given /^I have uploaded a (\w+) file to #{capture_model}$/ do |ext,mdl|
  Given %(I have uploaded "features/yeah.#{ext}" to #{mdl})
end
