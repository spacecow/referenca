Feature:

Scenario Outline: Delete an authorship
Given an article "main" exists
And an article "ref1" exists
And an article "ref2" exists
And article "main" references article "ref1"
And article "main" references article "ref2"
And I am logged in as "admin"
When I go to article: "main"'s edit page
And I check the <order> "Remove Reference"
And I press "Update Article"
Then article "<existing>" should be one of article "main"'s referenced_articles
And 1 references should exist
Examples:
| order  | existing |
| first  | ref2     |
| second | ref1     |
