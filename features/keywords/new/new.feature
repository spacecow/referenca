Feature:
Background:
Given I am logged in as "admin"

Scenario: If error, rendering of new keyword page
When I go to the new keyword page
And I press "Create Keyword"
Then I should see "New Keyword" as title

Scenario: Create a new keyword
When I go to the new keyword page
And I fill in "Name" with "ANN"
And I press "Create Keyword"
Then a keyword should exist with name: "ANN"
And 1 keywords should exist
And I should see "Successfully created keyword." as notice flash message
And I should be on the keywords page

Scenario: A keyword cannot be blank
When I go to the new keyword page
And I fill in "Name" with ""
And I press "Create Keyword"
Then I should see an keyword name error "can't be blank"

Scenario Outline: A keyword must be unique
Given a keyword exists with name: "ANN"
When I go to the new keyword page
And I fill in "Name" with "<input>"
And I press "Create Keyword"
Then I should see an keyword name error "has already been taken"
Examples:
| input |
| ANN   |
| ann   |
| AnN   |
