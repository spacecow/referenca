Feature:
Background:
Given I am logged in as "admin"

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
