Feature: Rate a news article
  As a voter
  So that others can judge an article's credibility
  I want to rate a news article

  Background:
    Given the following representatives exist:
      | name         | title   |
      | Wilson Jiang | Senator |
    And a news item titled "Transit Funding Update" exists for "Wilson Jiang"

  Scenario: A logged-in user rates an article
    Given I am logged in via github as "test"
    When I visit the news item "Transit Funding Update" for "Wilson Jiang"
    And I rate the article 4
    Then I should see an average rating of "4.0"

  Scenario: A signed-out visitor cannot rate
    When I visit the news item "Transit Funding Update" for "Wilson Jiang"
    Then I should see "Not yet rated"
    And I should not see "Rate"