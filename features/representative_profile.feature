Feature: Representative Profile Page
  As a voter
  So that I can learn about my elected officials
  I want to view a representative's profile

  Background:
    Given the following representatives exist:
      | name             | title          | party    | gender | address                         | phone        | contact_form                | website                  | twitter | facebook | youtube |
      | Max Yfantopoulos | representative | Democrat | M      | 123 Main Street, Washington DC | 202-555-0100 | https://example.com/contact | https://example.com      | maxrep  | maxrep   | maxrep  |

  Scenario: Viewing a representative's profile
    When I visit the profile page for "Max Yfantopoulos"
    Then I should see "Max Yfantopoulos"
    And I should see "representative"
    And I should see "Democrat"
    And I should see "123 Main Street, Washington DC"
    And I should see "202-555-0100"
    And I should see a link "Official Website" to "https://example.com"
    And I should see a link "Contact Form" to "https://example.com/contact"
    And I should see a link "Twitter" to "https://twitter.com/maxrep"
    And I should see a link "Facebook" to "https://www.facebook.com/maxrep"
    And I should see a link "YouTube" to "https://www.youtube.com/maxrep"

  Scenario: Viewing a representative with missing optional information
    Given the following representatives exist:
      | name          | title   |
      | Taylor Fields | Senator |
    When I visit the profile page for "Taylor Fields"
    Then I should see "Taylor Fields"
    And I should see "Senator"