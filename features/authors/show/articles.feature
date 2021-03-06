Feature:
Background:
Given an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an article exists with year: "2001"

@file
Scenario Outline: Only an article's owners or group members can see a file image
Given a user "owner" exists
And a user "normal" exists
And a user "secret" exists with group "secret"
And an article exists with group: group "secret", owner: user "owner"
And author "lifter" is one of that article's authors
And I am logged in as user "owner"
And I have uploaded a pdf file to that article
And I go to the logout page
And I am logged in as user "<user>"
When I go to author "lifter"'s page
Then I should see <listing> pdf image within the first listing
Examples:
| user   | listing |
| owner  | a       |
| normal | no      |
| secret | a       |

Scenario Outline: If no articles are connected, no articles should be shown
Given author "<author>" is one of that article's authors
When I go to author "lifter"'s page
Then I should see <article> "Articles" section
Examples:
| author  | article |
| lifter  | an      |
| dover   | no      |

Scenario: Links to co-authors
Given author "lifter" is one of that article's authors
And author "dover" is one of that article's authors
When I go to author "lifter"'s page
And I follow "Ben Dover"
Then I should be on the author "dover"'s page

Scenario: The authors own name should not be a link, instead marked
Given author "lifter" is one of that article's authors
When I go to author "lifter"'s page
Then I should see "Shop Lifter" within "span.exception"

Scenario: Should be displayed in order after YEAR
Given author "lifter" is one of that article's authors
And an article exists with year: "2003"
And author "lifter" is one of that article's authors
When I go to author "lifter"'s page
Then I should see "2003" within the first listing
And I should see "2001" within the second listing

Scenario: After editing an article, one should return to the author page
Given author "lifter" is one of that article's authors
And I am logged in as "admin"
When I go to author "lifter"'s page
And I follow "Edit" within the first listing
And I press "Update Article"
Then I should be on author "lifter"'s page

Scenario: A guest only have read access to articles
Given author "lifter" is one of that article's authors
When I go to author "lifter"'s page
Then I should see a link "Show" within the first listing
But I should see no link "Edit" within the first listing
And I should see no link "Del" within the first listing

Scenario: A user cannot delete an article on the show author page
Given author "lifter" is one of that article's authors
And I am logged in as "admin"
When I go to author "lifter"'s page
Then I should see a link "Show" within the first listing
But I should see no link "Del" within the first listing

Scenario Outline: Links within an article for a user
Given author "lifter" is one of that article's authors
And I am logged in as "admin"
When I go to author "lifter"'s page
And I follow "<link>" within the first listing
Then I should be on <redirect> page
Examples:
| link | redirect            |
| Show | that article's      |
| Edit | that article's edit |

@private
Scenario Outline: Articles that are private cannot be seen by guests
Given an article exists with title: "A secret title", private: <privacy>
And author "lifter" is one of that article's authors
When I go to author "lifter"'s page
Then I should <listing> "A secret title" within the first listing
Examples:
| listing | privacy |
| see     | false   |
| not see | true    |

@private
Scenario Outline: Private articles cannot be seen other than by owners or group members
Given a user "secret" exists with group "secret"
And a user "owner" exists
And a user "normal" exists
And an article exists with group: group "secret", title: "A secret title", owner: user "owner", private: <privacy>
And author "lifter" is one of that article's authors
And I am logged in as user "<username>"
When I go to author "lifter"'s page
Then I should <listing> "A secret title" within the first listing
Examples:
| username | listing | privacy |
| secret   | see     | true    |
| normal   | not see | true    |
| owner    | see     | true    |
| secret   | see     | false   |
| normal   | see     | false   |
| owner    | see     | false   |
