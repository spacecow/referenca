Feature:
Background:
Given an article exists
And a keyword "ann" exists with name: "ANN"

Scenario Outline: Keywords should be loaded after rendering error page
When I go to <path> page
And I fill in "<lbl>" with ""
And I press "<button>"
Then "Keyword" should have options "BLANK, ANN"
Examples:
| path                | lbl        | button         |
| the new article     | First name | Create Author  |
| that article's edit | First name | Create Author  |
| the new article     | Name       | Create Keyword |
| that article's edit | Name       | Create Keyword |
| the new article     | Title      | Create Article |
| that article's edit | Title      | Update Article |

Scenario: Keywords should be ordered alphabetically
Given a keyword exists with name: "agent programming"
When I go to the new article page
Then "Keyword" should have options "BLANK, agent programming, ANN"

