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
Then I should see "Dover" listed first
And I should see "Lifter" listed second

Scenario: Authors should be displayed in order after author and then YEAR
Given an article "2003" exists with year: "2003"
And keyword "ann" is one of article "2001" & article "2003"'s keywords
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And author "lifter" is one of article "2001" & article "2003"'s authors
When I go to keyword "ann"'s page
Then I should see "2003" listed first
And I should see "2001" listed second

Scenario: After editing an article, one should return to the author page
Given a keyword "ann" is one of article "2001"'s keywords
And I am logged in as "admin"
When I go to keyword "ann"'s page
And I follow "Edit" within the first listing
And I press "Update Article"
Then I should be on keyword "ann"'s page
