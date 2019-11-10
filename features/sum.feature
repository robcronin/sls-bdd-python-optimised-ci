Feature: Calling the sum endpoint

  Scenario: Calling sum with valid inputs
    Given I send 2 and 7 to the "/sum" endpoint
    Then I see 9 in the "result" of the response
    Given I send 243 and 729 to the "/sum" endpoint
    Then I see 972 in the "result" of the response

  Scenario: Calling sum with invalid inputs
    Given I send "2" and "7" to the "/sum" endpoint
    Then I get a 400 response