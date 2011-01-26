Feature:
Background:
Given an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And I am logged in as "admin"
When I go to the new article page

@pdf
Scenario Outline: The article should create a pdf file only if a pdf file is attached
When I fill in "Title" with "A cool title"
And I fill in "Year" with "2001"
And I select "Dover, Ben" from "Author"
And <extra>
And I press "Create Article"
Then an article should exist
And a file named: "Ben_Dover_(2001)_-_A_cool_title.pdf" <file> exist for that article
Examples:
| extra                                          | file       |
| I attach the file "features/yeah.pdf" to "PDF" | should     |
| I do nothing                                   | should not |

# Scenario: Article titles containing forbidden letters
# When I fill in "Title" with "A cool: title"
# And I fill in "Year" with "2001"
# And I attach the file "features/yeah.pdf" to "PDF"
# And I press "Create Article"
# Then an article should exist
# And a file named: "_(2001)_-_A_cool__title.pdf" should exist for that article
