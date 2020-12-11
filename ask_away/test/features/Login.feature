Feature: Login screen Validates and then Logs In
  Scenario: when email and password are in the specified format and login is clicked
    Given I have "emailfield" and "passfield" and "loginbutton"
    When I fill "emailfield" field with "escama@escama.pt"
    And I fill "passfield" field with "escama"
    Then I tap the "loginbutton" button
    Then I wait until the "mainScreen" is present