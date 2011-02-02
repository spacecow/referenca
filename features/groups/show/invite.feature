Feature:
Background:
Given a user exists with username: "test" and group "test"
And I am logged in as that user

Scenario Outline: Invite a user to the group
Given a user "ben" exists with username: "ben", email: "ben@hello.com"
When I go to that group's page
And I fill in "invite" with "<input>"
And I press "Invite"
Then a membership should exist with user: user "ben", group: that group, roles_mask: 2
And 3 memberships should exist
Examples:
| input         |
| ben           |
| ben@hello.com |

Scenario Outline: Error message if user cannot be found
Given a user "ben" exists with username: "ben", email: "ben@hello.com"
When I go to that group's page
And I fill in "invite" with "<input>"
And I press "Invite"
Examples:
| input     |
| be        |
| ben@hello |

Scenario: A user cannot be member twice
Given a user "ben" exists with username: "ben", email: "ben@hello.com"
And user "ben" is one of that group's users
When I go to that group's page
And I fill in "invite" with "ben"
And I press "Invite"
Then 3 memberships should exist
And I should see a membership user_id error "ben is already a member."
