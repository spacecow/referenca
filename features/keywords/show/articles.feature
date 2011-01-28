Feature:
Background:
Given a keyword "ann" exists with name: "ANN"
And a keyword "agent" exists with name: "agent programming"
And an article "2001" exists with year: "2001"

Scenario Outline: If no articles are connected, no articles should be shown
Given keyword "<keyword>" is one of article "2001"'s keywords
When I go to keyword "ann"'s page
Then I should see <article> "Articles" section
Examples:
| keyword | article |
| ann     | an      |
| agent   | no      |

Scenario Outline: Links to authors
Given keyword "ann" is one of article "2001"'s keywords
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And author "dover" is one of article "2001"'s authors
And author "lifter" is one of article "2001"'s authors
When I go to keyword "ann"'s page
And I follow "<author>"
Then I should be on the author "<redirect>"'s page
Examples:
| author      | redirect |
| Ben Dover   | dover    |
| Shop Lifter | lifter   |

Scenario: Authors should be displayed in order after AUTHOR and then year
Given an article "2003" exists with year: "2003"
And keyword "ann" is one of article "2001" & article "2003"'s keywords
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And author "lifter" is one of article "2003"'s authors
And author "dover" is one of article "2001"'s authors
When I go to keyword "ann"'s page
Then I should see "Dover" within the first listing
And I should see "Lifter" within the second listing

Scenario: Authors should be displayed in order after author and then YEAR
Given an article "2003" exists with year: "2003"
And keyword "ann" is one of article "2001" & article "2003"'s keywords
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And author "lifter" is one of article "2001" & article "2003"'s authors
When I go to keyword "ann"'s page
Then I should see "2003" within the first listing
And I should see "2001" within the second listing

Scenario: After editing an article, one should return to the author page
Given a keyword "ann" is one of article "2001"'s keywords
And I am logged in as "admin"
When I go to keyword "ann"'s page
And I follow "Edit" within the first listing
And I press "Update Article"
Then I should be on keyword "ann"'s page

Scenario: A guest only have read access to articles
Given keyword "ann" is one of that article's keywords
When I go to keyword "ann"'s page
Then I should see a link "Show" within the first listing
But I should see no link "Edit" within the first listing
And I should see no link "Del" within the first listing

Scenario: A user cannot delete an article on the show keyword page
Given keyword "ann" is one of that article's keywords
And I am logged in as "admin"
When I go to keyword "ann"'s page
Then I should see a link "Show" within the first listing
But I should see no link "Del" within the first listing

Scenario Outline: Links within an article for a user
Given keyword "ann" is one of that article's keywords
And I am logged in as "admin"
When I go to keyword "ann"'s page
And I follow "<link>" within the first listing
Then I should be on <redirect> page
Examples:
| link | redirect            |
| Show | that article's      |
| Edit | that article's edit |

@private
Scenario Outline: Articles that are private cannot be seen by other ppl
Given an article exists with private: true, title: "A secret title", year: "2002"
And keyword "ann" is one of that article's keywords
And a user "secret" exists
And a user "normal" exists
And user "secret" is one of that article's users
And I am logged in as user "<username>"
When I go to keyword "ann"'s page
Then I should <secret_view> "A secret title" within the first listing
Examples:
| username | secret_view |
| secret   | see         |
| normal   | not see     |
