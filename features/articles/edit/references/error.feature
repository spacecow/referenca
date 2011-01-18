Feature:
Background:
Given an article "main" exists
And an article "reference" exists with year: "2000", title: "Sexy"
And an author exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with article: article "reference", author: that author
And a reference exists with article: article "main", referenced_article: article "reference"

Scenario: If a reference has an error, an extra should not be creaded by update
When I go to article: "main"'s edit page
And I select "Dover (2000) - Sexy" as second reference
And I press "Update Article"
Then I should see a first reference
And I should see a second reference
But I should see no third reference
