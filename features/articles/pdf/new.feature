Feature:
Background:
Given an author: "dover" exists with first_name: "Ben", last_name: "Dover"

@pdf
Scenario Outline: The article should create a pdf file only if a pdf file is attached
When I go to the new article page
And I fill in "Title" with "A cool title"
And I fill in "Year" with "2001"
And I select "Dover, Ben" from "Author"
And <extra>
And I press "Create Article"
Then an article should exist
And a file named: "Ben_Dover_(2001)_-_A_cool_title.pdf" <file> exist for that article
Examples:
| extra                                          | file       |
| I attach the file "features/yeah.pdf" to "Pdf" | should     |
| I do nothing                                   | should not |
