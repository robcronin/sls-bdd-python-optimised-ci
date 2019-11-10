Feature: Calling the hello endpoint

  Scenario: Calling hello
    Given I call the "/hello" endpoint
    Then I see "Go Serverless v1.0! Your function executed successfully in python!" in the "message" of the response
