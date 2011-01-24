Feature:

Scenario: Create a new author
When I go to the new author page
And I fill in "First name" with "Peter"
And I fill in "Middle names" with "T. Oscar"
And I fill in "Last name" with "Winkelspoon"
And I press "Create Author"
Then an author should exist with first_name: "Peter", middle_names: "T. Oscar", last_name: "Winkelspoon"
And 1 authors should exist
And I should see "Successfully created author." as notice flash message
And 0 articles should exist
And 0 authorships should exist
And I should be on the authors page

Scenario: If error, rendering of new author page
When I go to the new author page
And I fill in "First name" with ""
And I press "Create Author"
Then I should see "New Author" as title

Scenario Outline: Neither first name nor last name can be blank
Given I am logged in as "admin"
When I go to the new article page
And I fill in "<lbl>" with ""
And I press "Create Author"
Then I should see an author <attr> error "can't be blank"
Examples:
| lbl        | attr       |
| First name | first_name |
| Last name  | last_name  |

@pending
Scenario: An authors name must be unique
# Given a keyword exists with name: "ANN"
# When I go to the new article page
# And I fill in "Name" with "ANN"
# And I press "Create Author"
# Then I should see an keyword name error "has already been taken"

