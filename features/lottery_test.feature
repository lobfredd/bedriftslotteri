Feature: lottery test
  ...

  Scenario: Lottery wont save without a company association
    Given I have a Lottery without company association
    Then lottery should not save

  Scenario: Lottery wont save without any awards
    Given I have a Lottery without any awards
    Then lottery should not save

  Scenario: Lottery will auto finish on time
    Given I have a lottery which starts in one day
    When 2 days have passed
    Then lottery should be finished

  Scenario: Request manually lottery finish
    Given I have a lottery which starts in one day
    When I manually finish lottery
    Then lottery should be finished

  Scenario: Get winners of lottery
    Given I have a lottery
    When I fetch the winners
    And I make a expected winners list
    Then I would get 4 winners
    And The winners of the lottery match the expected list

  Scenario: Get tickets bought by a user
    Given I have a lottery
    And I have a user named "User1"
    When I fetch tickets associated with that lottery and user
    Then I should get the corresponding tickets

  Scenario: Assert that a user has won the lottery
    Given I have a lottery
    And I have a user named "User1"
    When I check if the user has won
    Then it should be true

  Scenario: Assert that a user has not won the lottery
    Given I have a lottery
    And I have a user named "User6"
    When I check if the user has won
    Then it should not be true

  Scenario: Assert correct total price user have spent on lottery
    Given I have a lottery
    And I have a user named "User1"
    When I get the total price spent on lottery
    Then the total should be "22"

  Scenario: Assert the total number of tickets sold by a lottery
    Given I have a lottery
    When I fetch total sold tickets
    Then it should be "6"

  Scenario: Assert correct win_chance of a lottery
    Given I have a lottery
    When I fetch the win chance
    Then the win chance should be "20.0"

  Scenario: Assert correct win_chance of a lottery with no sold tickets
    Given I have a lottery with no sold tickets
    When I fetch the win chance
    Then the win chance should be "100.0"

  Scenario: Assert correct tickets left in lottery
    Given I have a lottery
    When I fetch tickets left in that lottery
    Then it should be "17" tickets left

  Scenario: Assert that the correct tickets left check works
    Given I have a lottery
    When I ask if there is "18" tickets left
    Then it should not be that many tickets left


  Scenario: Assert that the correct tickets left check works
    Given I have a lottery
    When I ask if there is "16" tickets left
    Then it should be that many tickets left