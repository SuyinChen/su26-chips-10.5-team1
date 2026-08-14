Feature: See article ratings in the news list

  Background:
    Given the following representatives exist:
      | name         | title   |
      | Wilson Jiang | Senator |
    And a news item titled "Transit Funding Update" exists for "Wilson Jiang"

  Scenario: An unrated article shows no average
    When I visit the news list for "Wilson Jiang"
    Then I should see "Not yet rated"

  Scenario: A rated article shows its average and count
    Given I am logged in via github as "test"
    When I visit the news item "Transit Funding Update" for "Wilson Jiang"
    And I rate the article 4
    And I visit the news list for "Wilson Jiang"
    Then I should see "4.0"
    And I should see "(1)"