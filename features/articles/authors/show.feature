Feature:

Scenario Outline: Keywords should be loaded after rendering error page
Given an article exists
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
When I go to <path> page
And I fill in "<lbl>" with ""
And I press "<button>"
Then "Author" should have options "BLANK, Dover, Ben"
Examples:
| path                | lbl        | button         |
| the new article     | First name | Create Author  |
| that article's edit | First name | Create Author  |
| the new article     | Name       | Create Keyword |
| that article's edit | Name       | Create Keyword |
| the new article     | Title      | Create Article |
| that article's edit | Title      | Update Article |
