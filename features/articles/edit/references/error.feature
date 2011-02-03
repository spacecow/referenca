Feature:
Background:
Given an article "main" exists
And an article "reference" exists with year: "2000", title: "Sexy"
And an author exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with article: article "reference", author: that author
And a reference exists with article: article "main", referenced_article: article "reference"
And I am logged in as "admin"

Scenario: A reference cannot be chosen a second time for the same article
When I go to article: "main"'s edit page
And I select "Dover (2000) - Sexy" as second reference
And I press "Update Article"
Then I should see an article references_attributes_1_referenced_article_id error "has already been taken"

