Feature:

Scenario Outline: Login must be correct
Given a user exists with username: "dover", email: "dover@example.com", password: "secret"
When I go to the login page
And I fill in "Username" with "<login>"
And I fill in "Password" with "<password>"
And I press "Log in"
Then I should <see_error> "Invalid login or password." as alert flash message
Examples:
| login             | password | see_error |
| dvr               | secret   | see       |
| dover@example.jp  | secret   | see       |
| dover             | scrt     | see       |
| dover@example.com | scrt     | see       |
| dover             | secret   | see no    |
| dover@example.com | secret   | see no    |


Scenario: Log in user
Given a user exists with username: "dover", password: "secret"
When I go to the login page
And I fill in "Username" with "dover"
And I fill in "Password" with "secret"
And I press "Log in"
