@private
Feature:
Background:
Given a user "owner" exists with group "owner"
And an article exists with owner: user "owner", group: group "owner"
And I am logged in as user "owner"

Scenario: Updating group
When I go to that article's edit page
And I select "owner" from "Group"
And I press "Update Private Fields"
Then a group should exist
And 1 groups should exist
And an article should exist with group: that group

Scenario: A user can only see his own groups when making an article private
Given a group exists with title: "other"
When I go to that article's edit page
Then "Group" should have options "owner"

# Scenario: An article can not leave group blank
# When I go to that article's edit page
# And I select "" from "Group"
# And I press "Update Private Fields"
# Then an article should exist with group: group "owner"
