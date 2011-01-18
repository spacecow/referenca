Feature:

Scenario: Delete an authorship
Given an article exists
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an authorship exists with author: author "dover", article: that article
And an authorship exists with author: author "lifter", article: that article
When I go to that article's edit page
And I check "Remove Author"
And I press "Update Article"
Then 1 authorships should exist
