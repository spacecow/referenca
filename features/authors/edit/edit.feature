Feature:
Background:
Given an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And I am logged in as "admin"

Scenario: Edit a keyword
When I go to that author's edit page
And I fill in "First name" with "Benjamin"
And I press "Update Author"
Then an author should exist with first_name: "Benjamin", last_name: "Dover"
And 1 authors should exist
And I should see "Successfully updated author." as notice flash message
And I should be on the authors page

Scenario: If error, rendering of the author edit page
When I go to that author's edit page
And I fill in "First name" with ""
And I press "Update Author"
Then I should see "Edit Author" as title
