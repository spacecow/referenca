Feature:
Background:
Given a user "normal" exists

Scenario Outline: Show image file
Given an article exists
And I am logged in as user "normal"
And I have uploaded a <ext> file to that article
When I go to that article's edit page
Then I should see a <ext> image within the "file" listing
Examples:
| ext |
| pdf |
| chm |

Scenario Outline: Authors should be sorted in alphabetical order
Given an article exists
And an author exists with first_name: "Shop", last_name: "Lifter"
And an author exists with first_name: "Ben", last_name: "Dover"
And I am logged in as user "normal"
When I go to that article's edit page
And <command1>
And <command2>
Then "Author" should have options "BLANK, Dover, Ben, Lifter, Shop"
Examples:
| command1                  | command2                 |
| I do nothing              | I do nothing             |
| I fill in "Title" with "" | I press "Update Article" |

Scenario Outline: Private options should only be shown owners or group members
Given a user "owner" exists
And a user "secret" exists with group "secret"
And an article exists with owner: user "owner", group: group "secret"
And I am logged in as user "<user>"
When I go to that article's edit page
Then I should see <listing> article private input listing
Examples:
| user   | listing |
| normal | no      |
| owner  | a       |
| secret | a       |

