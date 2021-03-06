Feature:

@download
Scenario: Download uploaded file
Given a user exists
Given I am logged in as that user
And an article exists with owner: that user
And I have uploaded a pdf file to that article
When I go to the articles page
And I click the pdf image within the first table row
Then I should be on that article's download page

@file
Scenario Outline: Show image file to owners or group members
Given a user "owner" exists
And a user "normal" exists
And a user "secret" exists with group "secret"
And an article exist with group: group "secret", owner: user "owner"
And I am logged in as user "owner"
And I have uploaded a <ext> file to that article
And I go to the logout page
And I am logged in as user "<user>"
When I go to the articles page
Then I should see <listing> image within the first table row
Examples:
| ext | user   | listing |
| pdf | owner  | a pdf   |
| chm | owner  | a chm   |
| pdf | normal | no pdf  |
| chm | secret | a chm   |

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

@links @authors
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

@links
Scenario: A guest only have read access to articles
Given an article exists
When I go to the articles page
Then I should see a "Show" link within the first table row
But I should see no "Edit" link within the first table row
And I should see no "Del" link within the first table row
And I should see no "New Article" link at the bottom of the page

@links
Scenario Outline: Links within an article for a user
Given a user "owner" exists
And a user "normal" exists
And a user "secret" exists with group "secret"
And an article exists with owner: user "owner", group: group "secret"
And I am logged in as user "<user>"
When I go to the articles page
Then I should see a "Show" link within the first table row
And I should see an "Edit" link within the first table row
And I should see <del> "Del" link within the first table row
Examples:
| user   | del |
| owner  | a   |
| normal | no  |
| secret | a   |

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
And a user "owner" exists
And an article exists with group: group "secret", title: "A secret title", private: <privacy>, owner: user "owner"
And I am logged in as user "<username>"
When I go to the articles page
Then I should <listing> "A secret title" within the first table row
Examples:
| username | listing | privacy |
| secret   | see     | true    |
| normal   | not see | true    |
| owner    | see     | true    |
| secret   | see     | false   |
| normal   | see     | false   |
| owner    | see     | false   |

