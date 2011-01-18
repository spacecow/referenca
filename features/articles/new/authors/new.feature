Feature:

Scenario: Create a user on the fly
When I go to the new article page
And I fill in "First name" with "Peter"
And I fill in "Middle names" with "T. Oscar"
And I fill in "Last name" with "Winkelspoon"
And I press "Create Author"
Then an author should exist with first_name: "Peter", middle_names: "T. Oscar", last_name: "Winkelspoon"
And 1 authors should exist
And 0 articles should exist
And 0 authorships should exist
And I should be on the new article page
