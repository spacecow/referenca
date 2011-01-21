Feature:

Scenario Outline: If error, redirection to either new or edit page
Given an article exists
When I go to <path> page
And I fill in "Name" with ""
And I press "Create Keyword"
Then I should see "<action> Article" as title
Examples:
| path                | action |
| the new article     | New    |
| that article's edit | Edit   |

Scenario Outline: References should be loaded after rendering
Given an article "main" exists with year: "2001", title: "Space Odyssey"
And an article "reference" exists with year: "2010", title: "Oh yeah!"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: article "reference"
And an authorship exists with author: author "dover", article: article "main"
When I go to <path> page
And I fill in "Name" with ""
And I press "Create Keyword"
Then "Reference" should have options "BLANK, Dover (2010) - Oh yeah!<extra>"
Examples:
| path                   | extra                          |
| the new article        | , Dover (2001) - Space Odyssey |
| article: "main"'s edit |                                |

Scenario Outline: After creation, redirection to either new or edit page
Given an article exists
When I go to <path> page
And I fill in "Name" with "ANN"
And I press "Create Keyword"
Then I should be on <path> page
Examples:
| path                |
| the new article     |
| that article's edit |
