Feature:
Background:
Given a user exists with username: "editor" and group "editor"
And I am logged in as that user

Scenario: Edit a group
When I go to that group's edit page
And I fill in "Title" with "something else"
And I press "Update Group"
Then a group should exist with title: "something else"
And 1 groups should exist
And a membership should exist with group: that group, user: that user
And 1 memberships should exist
And I should see "Successfully updated group." as notice flash message
And I should be on that group's page

