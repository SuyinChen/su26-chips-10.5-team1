Feature: Representative Profile Page
  As a voter
  So that I can learn about my elected officials
  I want to view a representative's profile

  Background:
    Given the following representatives exist:
      | name             | title         | party     | gender |
      | Max Yfantopoulos | representative | Democrat  | M      |
  
  Scenario: Viewing a representative's profile
    When I visit the profile page for "Max Yfantopoulos"
    Then I should see "Max Yfantopoulos"
    And I should see "representative"
    And I should see "Democrat"