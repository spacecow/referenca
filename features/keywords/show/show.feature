Feature:
Background:
Given a keyword "ann" exists with name: "ANN"

Scenario: Links at the bottom of the page for guest
When I go to keyword "ann"'s page
Then I should see no "Edit" link at the bottom of the page
And I should see no "Delete" link at the bottom of the page

Scenario Outline: Links at the bottom of the page for user
Given I am logged in as "admin"
When I go to keyword "ann"'s page
And I follow "<link>" at the bottom of the page
Then I should be on <redirect> page
And <no> keywords should exist
Examples:
| link   | redirect            | no |
| Edit   | that keyword's edit |  1 |
| Delete | the keywords        |  0 |

  
