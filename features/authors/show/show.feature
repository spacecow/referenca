Feature:
Background:
Given an author: "dover" exists with first_name: "Ben", last_name: "Dover"

Scenario: Links at the bottom of the page for guest
When I go to author "dover"'s page
Then I should see no "Edit" link at the bottom of the page
And I should see no "Delete" link at the bottom of the page

Scenario Outline: Links at the bottom of the page for user
Given I am logged in as "admin"
When I go to author "dover"'s page
And I follow "<link>" at the bottom of the page
Then I should be on <redirect> page
And <no> authors should exist
Examples:
| link   | redirect           | no |
| Edit   | that author's edit |  1 |
| Delete | the authors        |  0 | 

  
