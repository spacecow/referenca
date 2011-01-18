Feature:
Background:
Given an article "main" exists with year: "2001"
And an article "reference" exists with title: "Reference 1"
And an author "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with article: article "reference", author: author "dover"

Scenario: Reference an article
When I go to article: "main"'s edit page
And I select "Dover (2000) - Reference 1" from "Reference"
And I fill in "Note" with "Some text"
And I fill in "No" with "1" within "li.numeric"
And I press "Update Article"
And 1 references should exist
Then a reference should exist with article: article "main", referenced_article: article "reference", no: 1, note: "Some text"

@no_reference
Scenario: A blank reference should not be saved
When I go to article: "main"'s edit page
And I press "Update Article"
Then I should see "Successfully updated article."
Then 0 references should exist
