Feature:

@file
Scenario Outline: Show image file
Given an article exist
And I am logged in as "admin"
And I have uploaded a <ext> file to that article
When I go to the articles page
Then I should see a <ext> image within the first table row
Examples:
| ext |
| pdf |
| chm |

Scenario: Articles should be displayed in order after AUTHOR
Given an article "2" exists
And an article "1" exists
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: article "1"
And an authorship exists with author: author "lifter", article: article "2"
When I go to the articles page
Then I should see "Dover" within the first table row
And I should see "Lifter" within the second table row

Scenario: Articles should be displayed in order after author, then YEAR
Given an article "1" exists with year: "2007"
And an article "2" exists with year: "2010"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: article "1"
And an authorship exists with author: author "dover", article: article "2"
When I go to the articles page
Then I should see "2010" within the first table row
And I should see "2007" within the second table row

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

Scenario: A guest only have read access to articles
Given an article exists
When I go to the articles page
Then I should see a link "Show" within the first table row
But I should see no link "Edit" within the first table row
And I should see no link "Del" within the first table row
And I should see no link "New Article" at the bottom of the page

Scenario Outline: Links within an article for a user
Given an article exists
And a user exists
And I am logged in as that user
When I go to the articles page
And I follow "<link>" within the first table row
Then I should be on <redirect> page
And <no> articles should exist
Examples:
| link | redirect            | no |
| Show | that article's      |  1 |
| Edit | that article's edit |  1 |
| Del  | the articles        |  0 |

Scenario: Links at the bottom of the page for user
Given an article exists
And a user exists
And I am logged in as that user
When I go to the articles page
And I follow "New Article" at the bottom of the page
Then I should be on the new article page

@private
Scenario Outline: Articles that are private cannot be seen by other ppl
Given a user "secret" exists with group "secret"
And a user "normal" exists
And an article exists with group: group "secret", title: "A secret title"
And I am logged in as user "<username>"
When I go to the articles page
Then I should <secret_view> "A secret title" within the first table row
Examples:
| username | secret_view |
| secret   | see         |
| normal   | not see     |
