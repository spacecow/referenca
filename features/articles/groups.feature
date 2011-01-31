@private
Feature:
Background:

Scenario: Updating group
Given a user "owner" exists with username: "owner"
And an article exists with owner: user "owner"
And I am logged in as user "owner"
When I go to that article's edit page
And I select "owner" from "Group"
And I press "Update Article"
Then a group should exist
And 1 groups should exist
And an article should exist with group: that group

Scenario: A user can only see his own groups when making an article private
Given I am logged in as "admin"
And a group exists with title: "other"
When I go to the new article page
Then "Group" should have options "BLANK, admin"
