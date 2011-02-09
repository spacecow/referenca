Feature:
Background:
Given I am logged in as "user"

@blank
Scenario Outline: Last name cannot be left blank
When I go to the new author page
And I fill in "<field>" with ""
And I press "Create Author"
Then I should see <view> author <attrib> error "can't be blank"
Examples:
| field        | attrib       | view |
| First name   | first_name   | no   |
| Last name    | last_name    | an   |
| Middle names | middle_names | no   |

@duplicate
Scenario Outline: A duplicate of either first name or last name is ok
Given an author exists with first_name: "Ben", middle_names: "All", last_name: "Dover"
When I go to the new author page
And I fill in "First name" with "<input1>"
And I fill in "Middle name" with "<input2>"
And I fill in "Last name" with "<input3>"
And I press the submit button
Then 2 authors should exist
Examples:
| input1 | input2 | input3 |
| Ben    | All    | Over   |
| David  | All    | Dover  |
| Ben    | Side   | Dover  |

Scenario: The full name must be unique
Given an author exists with first_name: "Ben", last_name: "Dover", middle_names: "All"
When I go to the new author page
And I fill in "First name" with "Ben"
And I fill in "Middle name" with "All"
And I fill in "Last name" with "Dover"
And I press the submit button
Then 1 authors should exist
