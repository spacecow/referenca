Feature:

Scenario: Articles should be displayed in order after AUTHOR
Given an article "2" exists
And an article "1" exists
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: article "1"
And an authorship exists with author: author "lifter", article: article "2"
When I go to the articles page
Then the table's first row should contain "Dover"
And the table's second row should contain "Lifter"

Scenario: Articles should be displayed in order after author, then YEAR
Given an article "1" exists with year: "2007"
And an article "2" exists with year: "2010"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: article "1"
And an authorship exists with author: author "dover", article: article "2"
When I go to the articles page
Then the table's first row should contain "2010"
And the table's second row should contain "2007"

Scenario Outline: Author links on the articles index page
Given an article exists
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an authorship exists with author: author "dover", article: that article
And an authorship exists with author: author "lifter", article: that article
When I go to the articles page
And I follow "<link>"
Then I should be on author: "<author>"'s page
Examples:
| link        | author |
| Ben Dover   | dover  |
| Shop Lifter | lifter |
