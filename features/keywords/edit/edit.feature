Feature:
Background:
Given a keyword exists with name: "ANN"

Scenario: Edit a keyword
When I go to that keyword's edit page
And I fill in "Name" with "agent programming"
And I press "Update Keyword"
Then a keyword should exist with name: "agent programming"
And 1 keywords should exist
And I should see "Successfully updated keyword." as notice flash message
And I should be on the keywords page

Scenario: If error, rendering of the keyword edit page
When I go to that keyword's edit page
And I fill in "Name" with ""
And I press "Update Keyword"
Then I should see "Edit Keyword" as title
