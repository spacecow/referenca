Feature:
Background:
Given an article exists
And I am logged in as "admin"

Scenario Outline: Show image file
Given I have uploaded a <ext> file to that article
When I go to that article's edit page
Then I should see a <ext> image within the "file" listing
Examples:
| ext |
| pdf |
| chm |

Scenario Outline: Authors should be sorted in alphabetical order
Given an author exists with first_name: "Shop", last_name: "Lifter"
And an author exists with first_name: "Ben", last_name: "Dover"
When I go to that article's edit page
And <command1>
And <command2>
Then "Author" should have options "BLANK, Dover, Ben, Lifter, Shop"
Examples:
| command1                  | command2                 |
| I do nothing              | I do nothing             |
| I fill in "Title" with "" | I press "Update Article" |
