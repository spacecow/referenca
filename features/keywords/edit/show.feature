Feature:

Scenario Outline: Links at the bottom of the page
Given a keyword exists
When I go to that keyword's edit page
And I follow "<link>" at the bottom of the page
Then I should be on <redirect> page
And <no> keywords should exist
Examples:
| link   | redirect     | no |
| Show   | that keyword |  1 |
| Delete | the keywords |  0 |
