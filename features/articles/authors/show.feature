Feature:
Background:
Given an article exists
And I am logged in as "admin"

Scenario Outline: Authors should be loaded after rendering error page
Given an author: "dover" exists with first_name: "Ben", last_name: "Dover"
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

Scenario Outline: Display of author
Given an author exists with first_name: "<first_name>", middle_names: "<middle_names>", last_name: "Dover"
When I go to the new article page
Then "Author" should have options "BLANK, <options>"
Examples:
| first_name | options       | middle_names |
| Ben        | Dover, Ben S. | S.           |
|            | Dover         |              |
| Ben        | Dover, Ben    |              |
