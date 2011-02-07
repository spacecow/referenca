Feature:

Scenario: Files cannot be downloaded by guests
Given a user "user" exists
Given I am logged in as user "user"
And an article exists with owner: user "user"
And I have uploaded a pdf file to that article
And I go to the logout page
When I go to that article's download page
Then I should be on the login page

Scenario Outline: Files can only be downloaded by owners or group members
Given a user "secret" exists with group "secret"
And a user "owner" exists
And a user "normal" exists
And an article exists with group: group "secret", owner: user "owner"
And I am logged in as user "owner"
And I have uploaded a pdf file to that article
And I go to the logout page
And I am logged in as user "<user>"
When I go to that article's download page
Then I should <redirect> on that article's download page
Examples:
| user   | redirect |
| owner  | be       |
| secret | be       |
| normal | not be   |

