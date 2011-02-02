Feature:

Scenario Outline: Username,email nor password can be blank
When I go to the new user page
And I fill in "<label>" with ""
And I press "Sign up"
Then I should see an user <model> error "can't be blank"
Examples:
| label    | model    |
| Password | password |
| Username | username |
| Email    | email    |

Scenario: Create a new user
When I go to the new user page
And I fill in "Username" with "dover"
And I fill in "Email" with "dover@example.com"
And I fill in "Password" with "secret"
And I fill in "Password confirmation" with "secret"
And I press "Sign up"
Then I should see "Successfully created a new user." as notice flash message
And a user should exist with username: "dover", email: "dover@example.com"
And 1 users should exist
And I should be on the articles page
And I should see "Welcome dover."

Scenario: When a user is created, he becomes the leader of a group with his name
When I go to the new user page
And I fill in "Username" with "dover"
And I fill in "Email" with "dover@example.com"
And I fill in "Password" with "secret"
And I fill in "Password confirmation" with "secret"
And I press "Sign up"
Then a group should exist with title: "dover"
And 1 groups should exist
And a user should exist
And a membership should exist with user: that user, group: that group, roles_mask: 1
And 1 memberships should exist
