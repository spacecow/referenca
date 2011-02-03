Feature:
Background:
Given an article "main" exists with title: "Main article"
And a user "admin" exists with group "admin"

@invisible
Scenario Outline: Private articles the user have no ownership of should not be seen as references
Given a user "owner" exists
And a user "normal" exists
And a user "secret" exists with group "secret"
And an article "private" exist with group: group "secret", private: <privacy>, owner: user "owner"

When I go to article "main"'s edit page
Examples:
| privacy |
| false   |

Scenario Outline: An article cannot reference itself
Given I am logged in as that user
When I go to article: "main"'s edit page
And <command1>
And <command2>
Then "Reference" should have options "BLANK"
Examples:
| command1                  | command2                 |
| I do nothing              | I do nothing             |
| I fill in "Title" with "" | I press "Update Article" |

Scenario: View for reference options
Given I am logged in as that user
And an article "reference" exists with title: "A cool title", year: "2001"
And an author "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with article: article "reference", author: author "dover"
When I go to article: "main"'s edit page
Then "Reference" should have options "BLANK, Dover (2001) - A cool title"

Scenario: View for referenced article
Given an article "reference" exists with title: "A cool title", year: "2001"
And an author "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with article: article "reference", author: author "dover"
And a reference exists with article: article "main", referenced_article: article "reference"
When I go to article: "main"'s edit page
Then "Dover (2001) - A cool title" should be selected for "Reference"

Scenario: References should be ordered after AUTHOR and year
And an article "ref2" exists with title: "Cooler title", year: "2010"
Given an article "ref1" exists with title: "A cool title", year: "2001"
And an author "dover" exists with first_name: "Ben", last_name: "Dover"
And an author "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an authorship exists with article: article "ref1", author: author "dover"
And an authorship exists with article: article "ref2", author: author "lifter"
When I go to article: "main"'s edit page
Then "Reference" should have options "BLANK, Dover (2001) - A cool title, Lifter (2010) - Cooler title"

Scenario: References should be ordered after author and YEAR
Given an article "ref1" exists with title: "A cool title", year: "2001"
And an article "ref2" exists with title: "Cooler title", year: "2010"
And an author "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with article: article "ref1", author: author "dover"
And an authorship exists with article: article "ref2", author: author "dover"
When I go to article: "main"'s edit page
Then "Reference" should have options "BLANK, Dover (2010) - Cooler title, Dover (2001) - A cool title"
