Feature: Representative Profile Page
  As a voter
  So that I can learn about my elected officials
  I want to view a represenative's profile

  Background:
    Given the following representatives exist:
      | name             | title         | party     | gender |
      | Max Yfantopoulos | represenative | Democrat  | M      |
  
  Scenario: Viewing a represenative's profile
    When I visit the profile page for "Max Yfantopoulos"
    Then I should see "Max Yfantopoulos"
    And I should see "represenative"
    And I should see "Democrat"