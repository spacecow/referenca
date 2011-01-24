Feature:

Scenario Outline: Links at the bottom of the page
Given an author exists
And I am logged in as "admin"
When I go to that author's edit page
And I follow "<link>" at the bottom of the page
Then I should be on <redirect> page
And <no> authors should exist
Examples:
| link   | redirect     | no |
| Show   | that author  |  1 |
| Delete | the authors  |  0 |
