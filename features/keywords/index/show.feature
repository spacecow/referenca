Feature:
Background:
Given a keyword exists with name: "ANN"

Scenario: Keywords should be displayed in alhabetical order
Given a keyword exists with name: "agent programming"
When I go to the keywords page
Then the table's first row should contain "ANN"
And the table's second row should contain "agent programming"

Scenario Outline: Links within a keyword
When I go to the keywords page
And I follow "<link>" within the first table row
Then I should be on the <page> page
And <no> keywords should exist
Examples:
| link          | page           | no |
| Show          | keyword's      |  1 |
| Edit          | keyword's edit |  1 |
| Del           | keywords       |  0 |

Scenario: Links on the bottom of the page
When I go to the keywords page
And I follow "New Keyword" at the bottom of the page
Then I should be on the new keyword page
