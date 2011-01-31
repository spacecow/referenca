Feature:
Background:
Given an article exists
And I am logged in as "admin"
And an author: "ben" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with article: that article, author: author "ben"

@group
Scenario:
Given a user "owner" exists with username: "owner"
And a user "secret" exists with username: "secret" and group "secret"
And an article exists with group: group "secret", owner: user "owner"
And I am logged in as user "owner"
When I go to that article's edit page
Then "Group" should have options "BLANK, owner, secret"

Scenario Outline: Only owners or group members can edit an article if it is private
Given a user "secret" exists with group "secret"
And a user "owner" exists
And a user "normal" exists
And an article exists with group: group "secret", owner: user "owner", private: <privacy>
And I am logged in as user "<user>"
When I go to that article's edit page
Then I should <redirect> on that article's edit page
Examples:
| user   | redirect | privacy |
| secret | be       | true    |
| owner  | be       | true    |
| normal | not be   | true    |
| secret | be       | false   |
| owner  | be       | false   |
| normal | be       | false   |

Scenario: When editing an article, the no of authors should not double
When I go to that article's edit page
And I press "Update Article"
Then 1 authorships should exist

@change
Scenario: When changing an author, the previous author should be deleted
Given an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
When I go to that article's edit page
And I select "Lifter, Shop" from "Author"
And I press "Update Article"
Then 1 authorships should exist with article: that article, author: author "lifter"

@twice
Scenario: An author cannot be chosen twice
When I go to that article's edit page
And I fill in "Title" with ""
And I select "Dover, Ben" as second author
And I press "Update Article"
Then an authorship should exist with article: that article, author: author "ben"
And 1 authorships should exist
