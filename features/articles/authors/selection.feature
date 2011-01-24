Feature:

Scenario Outline: Delete an authorship
Given an article exists
And I am logged in as "admin"
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And an author: "lifter" exists with first_name: "Shop", last_name: "Lifter"
And that article is one of author "dover" & author "lifter"'s articles
When I go to that article's edit page
And I check the <order> "Remove Author"
And I press "Update Article"
Then author "<existing>" should be one of that article's authors
And 1 authorships should exist
Examples:
| order  | existing |
| first  | lifter   |
| second | dover    |
