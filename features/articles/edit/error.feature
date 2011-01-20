Feature:
Background:
Given an article exists

Scenario: A user cannot be chosen two times
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: that article
When I go to that article's edit page
And I select "Dover, Ben" as second author
And I press "Update Article"
Then I should see an article author error "Ben Dover has already been taken"

Scenario: An author error message should not be shown unless there's an error
When I go to that article's edit page
And I fill in "Title" with ""
And I press "Update Article"
Then I should see no article author error
