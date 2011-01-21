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
  path = "public/uploads/article/pdf/#{model(mdl).id}/"
  File.open(path+file).should be_true
end

Then /^a file named: "([^"]*)" should not exist for #{capture_model}$/ do |file,mdl|
  path = "public/uploads/article/pdf/#{model(mdl).id}/"
  begin
    File.open(path+file)
    false.should be_true
  rescue Errno::ENOENT
    true.should be_true
  end
end
