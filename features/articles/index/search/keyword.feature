Feature:
Background:
Given an article exist with title: "Oh yeah!"
And a keyword "ann" exists with name: "ANN"
And a keyword "agent" exists with name: "agent programming"
And that article is one of keyword "ann" & keyword "agent"'s articles

Scenario Outline: Search keyword in downcase or uppercase
When I go to the articles page
And I fill in "search" with "<search>"
And I select "Keyword" from "sort"
And I press "Search"
Then I should see a first table row
But I should see no second table row
And I should see "<result>"
Examples:
| search | result      |
| ann    | Oh yeah!    |
| AgenT  | Oh yeah!    |
| a      | Oh yeah!    |
