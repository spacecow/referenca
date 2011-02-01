Feature:
Background:
Given a keyword exists with name: "ANN"

Scenario: Keywords should be displayed in alhabetical order
Given a keyword exists with name: "agent programming"
When I go to the keywords page
Then I should see "agent programming" within the first table row
And I should see "ANN" within the second table row

Scenario Outline: Links within a keyword for a user
Given I am logged in as "admin"
When I go to the keywords page
And I follow "<link>" within the first table row
Then I should be on the <page> page
And <no> keywords should exist
Examples:
| link          | page           | no |
| Show          | keyword's      |  1 |
| Edit          | keyword's edit |  1 |
| Del           | keywords       |  0 |

Scenario: Links for a guest
When I go to the keywords page
Then I should see a "Show" link within the first table row
But I should see no "Edit" link within the first table row
And I should see no "Del" link within the first table row
And I should see no "New Keyword" link at the bottom of the page

Scenario: Links on the bottom of the page for a user
Given I am logged in as "admin"
When I go to the keywords page
And I follow "New Keyword" at the bottom of the page
Then I should be on the new keyword page
