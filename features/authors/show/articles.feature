Feature:
Background:
Given an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an article exists with year: "2001"

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
Then I should see "2003" listed first
And I should see "2001" listed second

Scenario: After editing an article, one should return to the author page
Given author "lifter" is one of that article's authors
And I am logged in as "admin"
When I go to author "lifter"'s page
And I follow "Edit" within the first listing
And I press "Update Article"
Then I should be on author "lifter"'s page
