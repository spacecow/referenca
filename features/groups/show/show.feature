Feature:
Background:
Given a user exists with username: "test" and group "test"
And I am logged in as that user

Scenario: Show group
Given a user "ben" exists with username: "ben"
And a user "lifter" exists with username: "lifter"
And a membership exists with user: user "ben", group: that group, roles_mask: 2
And a membership exists with user: user "lifter", group: that group, roles_mask: 2
When I go to that group's page
Then I should see "Leader: test"
And I should see "Members: ben, lifter"
