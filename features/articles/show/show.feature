
Feature:
Background:
Given an article "main" exists with title: "Default title", summarize: "Not very interesting.", journal: "IEICE", volume: 5, no: 2, start_page: 100, end_page: 120
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And the article is one of author "dover"'s articles
And a keyword "ann" exists with name: "ANN"
And a keyword "agent" exists with name: "agent programming"
And the article is one of keyword "ann" & keyword "agent"'s articles

Scenario: Basic layout of article show page
When I go to that article's page
Then I should see "Default title" as title
And I should see "Author: Ben Dover"
And I should see "Summary: Not very interesting."
And I should see "Keywords: ANN, agent programming"
And I should see "Journal: IEICE"
And I should see "Volume: 5"
And I should see "Issue: 2"
And I should see "Pages: 100-120"

@file
Scenario Outline: Show image file
Given I am logged in as "admin"
And I have uploaded a <ext> file to that article
When I go to that article's page
Then I should see a <ext> image within the file subsection
Examples:
| ext |
| pdf |
| chm |

@file @references
Scenario Outline: Show image file in references
Given I am logged in as "admin"
And I have uploaded a <ext> file to that article
And an article "reference" exists
Given a reference exists with article: article "<first>", referenced_article: article "<second>"
When I go to article "reference"'s page
Then I should see a <ext> image within the first listing
Examples:
| ext | first     | second    |
| pdf | main      | reference |
| chm | main      | reference |
| pdf | reference | main      |
| chm | reference | main      |


Scenario Outline: Links from the artice show page
When I go to that article's page
And I follow "<link>"
Then I should be on <redirect> page
Examples:
| link              | redirect          |
| Ben Dover         | author "dover"'s  |
| ANN               | keyword "ann"'s   |
| agent programming | keyword "agent"'s |
