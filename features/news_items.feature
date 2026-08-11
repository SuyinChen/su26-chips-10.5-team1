Feature: Search for a news article by issue

  Scenario: Search for news articles for a representative and issue
    Given I am logged in via github as "test"
    Given the following representatives exist:
      | name         | title   |
      | Wilson Jiang | Senator |
    Given I am on the create news article page for "Wilson Jiang"
    When I select "Wilson Jiang" from "Representative"
    And I select "Climate Change" from "Issue"
    And I press "Search"
    Then I should see "News search results"
    And I should see "Wilson Jiang"
    And I should see "Climate Change"
    And I should see "Climate Article One"
    And I should see "First climate change article"
    And I should see "https://example.com/article1"
    And I should see "Climate Article Five"
    And I should see 5 article choices


  Scenario: Save a selected article
    Given I am logged in via github as "test"
    Given the following representatives exist:
      | name         | title   |
      | Wilson Jiang | Senator |
    Given I am on the create news article page for "Wilson Jiang"
    When I select "Wilson Jiang" from "Representative"
    And I select "Climate Change" from "Issue"
    And I press "Search"
    And I choose "article_0"
    And I press "Save"
    Then I should see "News item was successfully created."
    And I should see "Climate Article One"

  Scenario: Saving without choosing an article
    Given I am logged in via github as "test"
    Given the following representatives exist:
      | name         | title   |
      | Wilson Jiang | Senator |
    Given I am on the create news article page for "Wilson Jiang"
    When I select "Wilson Jiang" from "Representative"
    And I select "Climate Change" from "Issue"
    And I press "Search"
    And I press "Save"
    Then I should see "For saving, please select an article."