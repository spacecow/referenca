Feature:

Scenario: Create a group
When I go to the new group page
And I fill in "Title" with "cool"
And I press "Create Group"
Then 1 groups should exist

Scenario: The name must be unique
