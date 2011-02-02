Feature:
Background:
Given a user exists with username: "user" and group "user"
Given I am logged in as that user 

Scenario Outline: The name must be unique
Given a group exists with title: "double"
When I go to <path> page
And I fill in "Title" with "double"
And I press the submit button
Then I should see a group title error "has already been taken"
Examples:
| path                 |
| the new group        |
| group: "user"'s edit |

Scenario Outline: Title cannot be left blank
When I go to <path> page
And I fill in "Title" with ""
And I press the submit button
Then I should see a group title error "can't be blank"
Examples:
| path                 |
| the new group        |
| group: "user"'s edit |
