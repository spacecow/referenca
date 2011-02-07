Feature:
Background:
Given a user "test" exists with group "test"
And I am logged in as that user

Scenario: Show group
Given a user "ben" exists with username: "ben"
And a user "lifter" exists with username: "lifter"
And a membership exists with user: user "ben", group: that group, roles_mask: 2
And a membership exists with user: user "lifter", group: that group, roles_mask: 2
When I go to that group's page
Then I should see "Leader: test"
And I should see "Members: ben, lifter"

Scenario Outline: Only the group leader can invite other members
Given a group "new" exists with title: "new"
And a membership exists with user: user "test", group: group "new", roles_mask: <role>
When I go to that group's page
Then I should see <view> "invitation" section
Examples:
| role | view |
|    1 | an   |
|    2 | no   |
