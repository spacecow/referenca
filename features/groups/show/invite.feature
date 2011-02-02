Feature:
Background:
Given a user exists with username: "test" and group "test"
And I am logged in as that user

Scenario: Invite a user to the group
When I go to that group's page
And I fill in "invite" with "ben"
And I press "Invite"
