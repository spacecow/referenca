Feature:
Background:
Given an article "oh" exists with title: "Oh yeah!"
And an article "hell" exists with title: "Hell Yeah!"
And an article "sonic" exists with title: "Super Sonic"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover", middle_names: "Alot More"
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an authorship exists with author: author "dover", article: article "oh"
And an authorship exists with author: author "lifter", article: article "hell"
And an authorship exists with author: author "lifter", article: article "sonic"
When I go to the articles page

Scenario Outline: Search author in downcase or uppercase
When I fill in "search" with "<search>"
And I select "Author" from "sort"
And I press "Search"
Then I should see a first table row
But I should see no second table row
And I should see "<result>"
Examples:
| search | result      |
| ben    | Oh yeah!    |
| oveR   | Oh yeah!    |
| LOT    | Oh yeah!    |

Scenario: All hits are supposed to show
When I fill in "search" with "s"
And I select "Author" from "sort"
And I press "Search"
Then I should see a first table row
And I should see a second table row
But I should see no third table row
And I should see "Hell Yeah!"
And I should see "Super Sonic"

Scenario Outline: After another sort is chosen, it should stay
When I select "<sort>" from "sort"
And I press "Search"
Then "<sort>" should be selected for "sort"
Examples:
| sort    |
| Title   |
| Year    |
| Author  |
| Keyword |

