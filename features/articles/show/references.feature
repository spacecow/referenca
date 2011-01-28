Feature:
Background:
Given an article "main" exists
And an article "reference" exists with title: "Reference"
And an article "other" exists

@private
Scenario Outline: A reference to a private article should not be shown unless its the user's
Given an article "private" exists with private: true
And article "<main1>" references article "<ref1>"
And article "<main2>" references article "<ref2>"
When I go to article "main"'s page
Then I should see "Reference" within the first listing
But I should see no second listing
Examples:
| main1   | main2     | ref1    | ref2      |
| main    | main      | private | reference |
| private | reference | main    | main      |

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
