Feature:
Background:
Given an article exists with title: "A cool title", year: "2001"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: that article
And I am logged in as "admin"

@no_pdf
Scenario Outline: The article should create a pdf file only if a pdf file is attached
When I go to that article's edit page
And <extra>
And I press "Update Article"
Then an article should exist
And a file named: "Ben_Dover_(2001)_-_A_cool_title.pdf" <file> exist for that article
Examples:
| extra                                          | file       |
| I attach the file "features/yeah.pdf" to "PDF" | should     |
| I do nothing                                   | should not |

@pdf
Scenario Outline: The article should create a pdf file only if a pdf file is attached
Given an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
When I go to that article's edit page
And I attach the file "features/yeah.pdf" to "PDF"
And I press "Update Article"
And I go to that article's edit page
And I select "Lifter, Shop" as second author
And <extra>
And I press "Update Article"
Then an article should exist
And a file named: "Ben_Dover_(2001)_Shop_Lifter_-_A_cool_title.pdf" should exist for that article
Examples:
| extra                                          |
| I do nothing                                   |
| I attach the file "features/yeah.pdf" to "PDF" |

@delete @author
Scenario: When an author is deleted, he should be deleted from the filename as well
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an authorship exists with author: author "lifter", article: that article
When I go to that article's edit page
And I attach the file "features/yeah.pdf" to "PDF"
And I press "Update Article"
And I go to that article's edit page
And I check "Remove Author"
And I press "Update Article"
Then an article should exist
And a file named: "Shop_Lifter_(2001)_-_A_cool_title.pdf" should exist for that article
