Feature:
Background:
Given an article "main" exists with title: "Default title", summarize: "Not very interesting.", journal: "IEICE", volume: 5, no: 2, start_page: 100, end_page: 120
And an author: "dover" exists with first_name: "Ben", last_name: "Dover"
And the article is one of author "dover"'s articles
And a keyword "ann" exists with name: "ANN"
And a keyword "agent" exists with name: "agent programming"
And the article is one of keyword "ann" & keyword "agent"'s articles

@links
Scenario: There are no links at the bottom of the page for guest
When I go to article "main"'s page
Then I should see no links at the bottom of the page

@links
Scenario Outline:
Given a user "owner" exists
And a user "normal" exists
And a user "secret" exists with group "secret"
And an article exists with group: group "secret", owner: user "owner", private: <privacy>
And I am logged in as user "<user>"
When I go to that article's page
Then I should see an "Edit" link at the bottom of the page
And I should see <del> "Delete" link at the bottom of the page
Examples:
| user   | del | privacy |
| secret | a   | true    |
| owner  | a   | true    |
| secret | a   | false   |
| normal | no  | false   |
| owner  | a   | false   |

@private
Scenario Outline: Guests cannot see private articles
Given a user "secret" exists with group "secret"
And an article "private" exists with group: <group>, private: <privacy>
When I go to article "private"'s page
Then I should be on <redirect> page
Examples:
| group          | redirect       | privacy |
| group "secret" | the login      | true    |
| group "secret" | that article's | false   |

@private
Scenario Outline: Cannot see an article that's private and user has no membership/ownership
Given a user "normal" exists
And a user "owner" exists
And a user "private" exists with group "private"
And an article "private" exists with group: group "private", private: <privacy>, owner: user "owner"
And I am logged in as user "<user>"
When I go to article "private"'s page
Then I should be on <redirect> page
Examples:
| user    | redirect       | privacy |
| private | that article's | true    |
| normal  | the login      | true    |
| owner   | that article's | true    |
| private | that article's | false   |
| normal  | that article's | false   |
| owner   | that article's | false   |

@private
Scenario: User is both owner and group member
Given a user exists with group "group"
And an article exists with group: group "group", private: true, owner: that user
And I am logged in as that user
When I go to that article's page
Then I should be on that article's page

Scenario: Basic layout of article show page
When I go to that article's page
Then I should see "Default title" as title
And I should see "Author: Ben Dover"
And I should see "Summary: Not very interesting."
And I should see "Keywords: ANN, agent programming"
And I should see "Journal: IEICE"
And I should see "Volume: 5"
And I should see "Issue: 2"
And I should see "Pages: 100-120"

@file
Scenario Outline: Image file is shown to owners or group members
Given a user "owner" exists
And a user "normal" exists
And a user "secret" exists with group "secret"
And an article "owner" exists with owner: user "owner", group: group "secret"
And I am logged in as user "owner"
And I have uploaded a <ext> file to article: "owner"
And I go to the logout page
And I am logged in as user "<user>"
When I go to article "owner"'s page
Then I should <listing> image within the file subsection
Examples:
| ext | user   | listing    |
| pdf | owner  | see a pdf  |
| chm | owner  | see a chm  |
| pdf | normal | see no pdf |
| chm | secret | see a chm  |

@file @references
Scenario Outline: Image file in references is only shown to owners or group members
Given a user "owner" exists
And an article "owner" exists with owner: user "owner"
And I am logged in as user "owner"
And I have uploaded a <ext> file to article: "owner"
And an article "reference" exists
And article "<first>" references article "<second>"
When I go to article "reference"'s page
Then I should see a <ext> image within the first listing
Examples:
| ext | first     | second    |
| pdf | owner     | reference |
| chm | owner     | reference |
| pdf | reference | owner     |
| chm | reference | owner     |

@links
Scenario Outline: Links from the artice show page
When I go to that article's page
And I follow "<link>"
Then I should be on <redirect> page
Examples:
| link              | redirect          |
| Ben Dover         | author "dover"'s  |
| ANN               | keyword "ann"'s   |
| agent programming | keyword "agent"'s |

