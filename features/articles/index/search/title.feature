Feature:
Background:
Given an article exists with title: "Oh yeah!"
And an article exists with title: "Hell Yeah!"
And an article exists with title: "Super Sonic"
When I go to the articles page

Scenario Outline: Search title in downcase or uppercase
When I fill in "search" with "<search>"
And I press "Search"
Then I should see a first table row
But I should see no second table row
And I should see "<result>"
Examples:
| search | result      |
| Sonic  | Super Sonic |
| hell   | Hell Yeah!  |
| OH     | Oh yeah!    |

Scenario: All hits are supposed to show
When I fill in "search" with "yeah!"
And I press "Search"
Then I should see a first table row
And I should see a second table row
But I should see no third table row
And I should see "Oh yeah!"
And I should see "Hell Yeah!"
