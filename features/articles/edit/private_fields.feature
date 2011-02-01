Feature:

Scenario Outline:
Given a user "owner" exists
And a user "normal" exists
And a user "secret" exists with group "secret"
And an article exists with group: group "secret", owner: user "owner"
And I am logged in as user "<user>"
When I go to that article's edit page
Then I should see <listing> "private fields" section
Examples:
| user   | listing |
| owner  | a       |
| normal | no      |
| secret | a       |
