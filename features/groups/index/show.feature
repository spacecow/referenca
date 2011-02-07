Feature:
Background:
Given a user exists with username: "cool" and group "cool"
And I am logged in as that user

Scenario: Only one's own groups are listed
Given a group exists with title: "lame"
When I go to the groups page
Then I should see "cool" within the first table row
But I should see no second table row

@order
Scenario: Groups are listed alphabetically
Given a group exists with title: "abc"
And a membership exists with group: that group, user: that user, roles_mask: 1
When I go to the groups page
Then I should see table "groups"
| abc  | Leader | Show | Edit | Del |
| cool | Leader | Show | Edit | Del |

@links
Scenario Outline: Links within a group
When I go to the groups page
And I follow "<link>" within the first table row
Then I should be on <redirect> page
And <no> groups should exist
Examples:
| link | redirect          | no |
| Show | that group's      |  1 |
| Edit | that group's edit |  1 |
| Del  | the groups        |  0 |

@links
Scenario: Links on the bottom of the page
When I go to the groups page
And I follow "New Group" at the bottom of the page
Then I should be on the new group page
