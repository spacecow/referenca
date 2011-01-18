Feature:
Background:
Given an article exists
When I go to that article's edit page
And I press "Create Author"

Scenario: If you don't fill in author correctly you will be taken to its form
Then I should be on the authors page

Scenario: After correcting once, you should be back on the new article page
When I fill in "First name" with "Ben"
And I fill in "Last name" with "Dover"
And I press "Create Author"
Then I should be on that article's edit page

Scenario: After correcting twice, you should be back on the new article page
And I press "Create Author"
When I fill in "First name" with "Ben"
And I fill in "Last name" with "Dover"
And I press "Create Author"
Then I should be on that article's edit page
