Feature:
Background:
Given a keyword "ann" exists with name: "ANN"
And a user exists with group "admin"
And I am logged in as that user

Scenario Outline: If no keyword is selected, no links should be created
When I go to the new article page
And I fill in "Title" with "Some title"
And I fill in "Year" with "1899"
And <extra>
And I press "Create Article"
Then 1 articles should exist
But <no> articles_keywords should exist
Examples:
| extra                         | no |
| I do nothing                  |  0 |
| I select "ANN" from "Keyword" |  1 |

Scenario Outline: Delete a keyword relation
Given an article exists
And a keyword "agent" exists with name: "agent programming"
And that article is one of keyword "ann" & keyword "agent"'s articles
When I go to that article's edit page
And I check the <order> "Remove Keyword"
And I press "Update Article"
Then keyword "<existing>" should be one of that article's keywords
And 1 articles_keywords should exist
Examples:
| order  | existing |
| first  | agent    |
| second | ann      |

Scenario: The same keyword cannot be added twice
Given an article exists
And that article is one of keyword "ann"'s articles
When I go to that article's edit page
And I select "ANN" as second keyword
And I press "Update Article"
Then I should see an article keyword error "ANN has already been taken" 
