Feature:
Background:
Given a user exists with username: "editor" and group "editor"
And I am logged in as that user

Scenario: Form
When I go to that group's edit page
Then the "Title" field should contain "editor"

@links
Scenario Outline: Links on the bottom of the page
When I go to that group's edit page
And I follow "<link>" at the bottom of the page
Then I should be on <redirect> page
And <no> groups should exist
Examples:
| redirect     | link   | no |
| that group's | Show   |  1 |
| the groups   | Delete |  0 |
