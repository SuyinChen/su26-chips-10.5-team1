Feature: Create a news article with an issue

Scenario: Create a news article and select an issue
  Given I am logged in via github as "test"
  Given the following representatives exist:
      | name         | title   |
      | Wilson Jiang | Senator |
  Given I am on the create news article page for "Wilson Jiang"
  Then show me the page
  When I fill in "Title" with "Example Article CC"
  And I fill in "Link" with "https://example.com/article"
  And I fill in "Description" with "An article about CC"
  And I select "Wilson Jiang" from "Representative"
  And I select "Climate Change" from "Issue"
  And I press "Save"
  Then I should see "Climate Change"
  And I should see "Example Article CC"