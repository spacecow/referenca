Feature:
Background:
Given an author exists with first_name: "Ben", last_name: "Dover"
#And a group "default" exists with title: "default"
#And a user exists with username: "default"
#And group "default" is one of that user's groups
And a user exists with group "default"
And I am logged in as that user

@authorship
Scenario: The article should create authorsships if an author is chosen
When I go to the new article page
And I fill in "Title" with "Some cool title"
And I fill in "Year" with "2001"
And I select "Dover, Ben" from "Author"
And I press "Create Article"
Then 1 authorships should exist

Scenario: Create a new article
When I go to the new article page
And I fill in "Title" with "Some cool title"
And I fill in "Year" with "2001"
And I select "Dover, Ben" from "Author"
And I press "Create Article"
Then I should see "Successfully created article." as notice flash message
Then an article should exist with title: "Some cool title", year: "2001"
And 1 articles should exist
And 1 authors should exist
And 1 authorships should exist with article: that article, author: that author
And I should be on that article's page

@owner
Scenario: Owner is set when creating a new article
When I go to the new article page
And I fill in "Title" with "Some cool title"
And I fill in "Year" with "2001"
And I select "Dover, Ben" from "Author"
And I press "Create Article"
Then an article should exist with owner: that user

@group
Scenario: Group is set when creating a new article
When I go to the new article page
And I fill in "Title" with "Some cool title"
And I fill in "Year" with "2001"
And I press "Create Article"
Then an article should exist with group: group "default"
