Feature:
Background:
Given an article exists
And I am logged in as "admin"
And an author: "ben" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with article: that article, author: author "ben"

Scenario: When editing an article, the no of authors should not double
When I go to that article's edit page
And I press "Update Article"
Then 1 authorships should exist

@change
Scenario: When changing an author, the previous author should be deleted
Given an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
When I go to that article's edit page
And I select "Lifter, Shop" from "Author"
And I press "Update Article"
Then 1 authorships should exist with article: that article, author: author "lifter"

@twice
Scenario: An author cannot be chosen twice
When I go to that article's edit page
And I fill in "Title" with ""
And I select "Dover, Ben" as second author
And I press "Update Article"
Then an authorship should exist with article: that article, author: author "ben"
And 1 authorships should exist
