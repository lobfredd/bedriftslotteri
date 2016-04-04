Feature: company
  ...


  Scenario: Save company without name should fail
    Given I make a company without a name
    Then company should not save

  Scenario: Save company with too short key
    Given I make a Company with a too short key
    Then company should not save

  Scenario: Company should not save without company-user
    Given I make a company
    Then company should not save

  Scenario: Company should save with company-user
    Given I make a company
    When I assigns a company-user
    Then company should save

  Scenario: Company can only have one company-user
    Given I have a company with an existing company-user relation
    When I add another company-user
    Then company should not save

  Scenario: Fetch all regular users in company
    Given I have a company
    When I fetch all regular users
    Then that list should only contain regular users

  Scenario: Fetch top 5 winners
    Given I have a company
    When I fetch top 5 winners
    And I make a expected winners list
    Then The winners match the expected list

  Scenario: Get upcoming lotteries
    Given I have a company
    When I fetch upcoming lotteries
    Then each lottery should have a start date greater than now
    And it should be 8 upcoming lotteries
    And it should not include a finished lottery

  Scenario: get past lotteries
    Given I have a company
    When I fetch past lotteries
    Then each lottery should have a start date before now

  Scenario: Get average winning chance
    Given I have a company
    When I fetch average winning chance
    Then it should be equal to "87.5"

  Scenario: Average winning chance should be 0 if no tickets sold
    Given I have a company without any sold tickets
    When I fetch average winning chance
    Then it should be 0

  Scenario: Searching for a regular users first name
    Given I have a company
    When I search for "ser1"
    Then I should get "User1"

  Scenario: Fetch todays winning chance
    Given I have a company which have a lottery due today
    When I fetch todays winning chance
    Then It should be "3"

  Scenario: Fetch todays winning chance, with no lotteries due today
    Given I have a company without any sold tickets
    When I fetch todays winning chance
    Then It should be "0"