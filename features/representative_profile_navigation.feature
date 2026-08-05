Feature: Navigate to representative profiles
  As a voter
  So that I can learn more about a representative
  I want to open a representative's profile from search results and news pages

  Scenario: Open a profile from representative search results
    When I search for representatives at "Berkeley, CA"
    Then I should see a profile link for "Jane Doe"
    When I follow the profile link for "Jane Doe"
    Then I should arrive at the profile page for "Jane Doe"

  Scenario: Open a profile from the representative's news list
    Given the following representatives exist:
      | name         | title   |
      | Wilson Jiang | Senator |
    When I visit the news list for "Wilson Jiang"
    Then I should see a profile link for "Wilson Jiang"
    When I follow the profile link for "Wilson Jiang"
    Then I should arrive at the profile page for "Wilson Jiang"

  Scenario: Open a profile from a news item
    Given the following representatives exist:
      | name         | title   |
      | Wilson Jiang | Senator |
    And a news item titled "Transit Funding Update" exists for "Wilson Jiang"
    When I visit the news item "Transit Funding Update" for "Wilson Jiang"
    Then I should see a profile link for "Wilson Jiang"
    When I follow the profile link for "Wilson Jiang"
    Then I should arrive at the profile page for "Wilson Jiang"