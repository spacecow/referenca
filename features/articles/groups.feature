@private
Feature:
Background:
Given I am logged in as "admin"

Scenario: Making an article private to a group
Given an article exists
When I go to that article's edit page
And I select "admin" from "Group"
And I press "Update Article"
Then a group should exist
And 1 groups should exist
And an article should exist with group: that group

Scenario: A user can only see his own groups when making an article private
Given a group exists with title: "other"
When I go to the new article page
Then "Group" should have options "BLANK, admin"
