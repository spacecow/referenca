Feature:

Scenario: Log out
Given a user exists
And a user is logged in as that user
And I follow "Log out"
Then I should see no "You must first log in or sign up before accessing this page." as alert flash message
