Feature:
Background:
Given an author exists with first_name: "Ben", last_name: "Dover"

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
#Then I should see flash notice message /Successfully created article./
Then an article should exist with title: "Some cool title", year: "2001"
#And I should be redirected to that article's page
And 1 articles should exist
And 1 authors should exist
And 1 authorships should exist with article: that article, author: that author

