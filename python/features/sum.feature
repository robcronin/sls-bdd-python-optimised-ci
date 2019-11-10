Feature: Calling the sum endpoint

  Scenario: Calling sum
    Given I send 2 and 7 to the "/sum" endpoint
    Then I see 9 in the "result" of the response
