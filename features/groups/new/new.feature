Feature:
Background:
Given a user exists with group "user"
Given I am logged in as that user

Scenario: Create a group
When I go to the new group page
And I fill in "Title" with "cool"
And I press "Create Group"
Then a group should exist with title: "cool"
And 2 groups should exist
And a membership should exist with group: that group, user: that user, roles_mask: 1
And 2 memberships should exist
And I should see "Successfully created group." as notice flash message
And I should be on the groups page
