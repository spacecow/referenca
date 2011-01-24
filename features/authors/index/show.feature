Feature:
Background:
Given an author: "dover" exists with first_name: "Ben", last_name: "Dover"

Scenario: Author should be displayed in alhabetical order
Given an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
When I go to the authors page
Then I should see "Dover" within the first table row
And I should see "Lifter" within the second table row

Scenario Outline: Links within an author for a user
Given I am logged in as "admin"
When I go to the authors page
And I follow "<link>" within the first table row
Then I should be on the <page> page
And <no> authors should exist
Examples:
| link          | page           | no |
| Show          | author's       |  1 |
| Edit          | author's edit  |  1 |
| Del           | authors        |  0 |

Scenario: Links for a guest
When I go to the authors page
Then I should see a link "Show" within the first table row
But I should see no link "Edit" within the first table row
And I should see no link "Del" within the first table row
And I should see no link "New Author" at the bottom of the page

Scenario: Links on the bottom of the page for a user
Given I am logged in as "admin"
When I go to the authors page
And I follow "New Author" at the bottom of the page
Then I should be on the new author page
