Feature:
Background:
Given a user exists
And I am logged in as that user

Scenario: Default view of the new article page
When I go to the new article page
Then I should see "Title"
And I should see "Author"

Scenario: Authors should be sorted in alphabetical order
Given an author exists with first_name: "Shop", last_name: "Lifter"
And an author exists with first_name: "Ben", last_name: "Dover"
When I go to the new article page
Then "Author" should have options "BLANK, Dover, Ben, Lifter, Shop"

Scenario: Authors should be sorted in alphabetical order after re-render
Given an author exists with first_name: "Shop", last_name: "Lifter"
And an author exists with first_name: "Ben", last_name: "Dover"
When I go to the new article page
And I press "Create Article"
Then "Author" should have options "BLANK, Dover, Ben, Lifter, Shop"

