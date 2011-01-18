Feature:
Background:
Given an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And an article exists with year: "2001"

Scenario: An authors articles should be shown
Given an authorship exists with author: author "lifter", article: that article
When I go to author "lifter"'s page
Then I should see an "Articles" section

Scenario: If an author have no articles, no articles should be shown
When I go to author "lifter"'s page
Then I should see no "Articles" section

Scenario: Links to co-authors
Given an authorship exists with author: author "lifter", article: that article
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an authorship exists with author: author "dover", article: that article
When I go to author "lifter"'s page
And I follow "Ben Dover"
Then I should be on the author "dover"'s page

Scenario: The authors own name should not be a link, instead marked
Given an authorship exists with author: author "lifter", article: that article
When I go to author "lifter"'s page
Then I should see "Shop Lifter" within "span.exception"

Scenario: Should be displayed in order after YEAR
Given an authorship exists with author: author "lifter", article: that article
And an article exists with year: "2003"
And an authorship exists with author: author "lifter", article: that article
When I go to author "lifter"'s page
Then I should see "2003" listed first
And I should see "2001" listed second

Scenario: After editing an article, one should return to the author page
Given an authorship exists with author: author "lifter", article: that article
When I go to author "lifter"'s page
And I follow "Edit" within the first listing
And I press "Update Article"
Then I should be on author "lifter"'s page
