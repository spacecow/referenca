Feature:

Scenario: Log out
Given I am logged in as "admin"
And I follow "Log out"
Then I should see no "You must first log in or sign up before accessing this page." as alert flash message
