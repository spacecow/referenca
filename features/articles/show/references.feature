Feature:
Background:
Given an article "main" exists with private: false
And an article "reference" exists with title: "Reference"
And an article "other" exists

@download
Scenario: Download a referenced article
Given a user exists
And an article "user" exists with owner: that user
And article "main" references article "user"
And I am logged in as that user
And I have uploaded a pdf file to article: "user"
When I go to article "main"'s page
And I click the pdf image within the first listing
Then I should be on article: "user"'s download page

@private
Scenario Outline: Guest cannot see references to private articles
Given an article "private" exists with private: <privacy>, title: "my article"
And article "<main1>" references article "<ref1>"
And article "<main2>" references article "<ref2>"
When I go to article "main"'s page
Then I should see "<listing>" within the first listing
But I should see <secret> second listing
Examples:
| main1   | main2     | ref1    | ref2      | privacy | secret | listing    |
| main    | main      | private | reference | true    | no     | Reference  |
| private | reference | main    | main      | true    | no     | Reference  |
| main    | main      | private | reference | false   | a      | my article |
| private | reference | main    | main      | false   | a      | my article |

@private
Scenario Outline: A reference to a private article should not be shown unless its the user's
Given a user "secret" exists with group "secret"
And a user "normal" exists
And a user "owner" exists
And an article "private" exists with group: group "secret", private: <privacy>, owner: user "owner", title: "my article"
And article "<main1>" references article "<ref1>"
And article "<main2>" references article "<ref2>"
And I am logged in as user "<user>"
When I go to article "main"'s page
Then I should see "<title>" within the first listing
But I should see <listing> second listing
Examples:
| main1   | main2     | ref1    | ref2      | privacy | user   | title      | listing |
| main    | main      | private | reference | true    | normal | Reference  | no      |
| private | reference | main    | main      | true    | normal | Reference  | no      |
| main    | main      | private | reference | true    | secret | my article | a       |
| private | reference | main    | main      | true    | secret | my article | a       |
| main    | main      | private | reference | true    | owner  | my article | a       |
| private | reference | main    | main      | true    | owner  | my article | a       |

Scenario Outline: If the article references nothing, references should not be displayed
Given a reference exists with article: article "<article>", referenced_article: article "reference"
When I go to article "main"'s page
Then I should see <section> "References" section
Examples:
| article | section |
| main    | a       |
| other   | no      |

Scenario Outline: If the article is not referenced from another article, that section should not be visible
Given a reference exists with article: article "reference", referenced_article: article "<article>"
When I go to article "main"'s page
Then I should see <section> "Referenced from" section
Examples:
| article | section |
| main    | a       |
| other   | no      |

Scenario: Authors in references should be clickable
Given a reference exists with article: article "main", referenced_article: article "reference"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: article "reference"
When I go to article "main"'s page
And I follow "Ben Dover"
Then I should be on author "dover"'s page

Scenario: Authors in referenced from should be clickable
Given a reference exists with article: article "reference", referenced_article: article "main"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: article "reference"
When I go to article "main"'s page
And I follow "Ben Dover"
Then I should be on author "dover"'s page
