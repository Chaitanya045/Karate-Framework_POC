#API Key = d331c6d0306950ea15c1be8870875a60
#Secret = 0980fbe7abf01f81dddd188a19e5c8c561626d9912608f6f3a2686f9b632fd54
#Token = ATTA1a7971bfbd25f0320bc6fdd8b8467298dcba14ce3bfcb73d276ecca13c3adf95F2278C40
Feature: Trello API

  Background: 
    * url 'https://api.trello.com'
    * header Accept = 'application/json'
    * def keyVal = 'd331c6d0306950ea15c1be8870875a60'
    * def tokenVal = 'ATTA1a7971bfbd25f0320bc6fdd8b8467298dcba14ce3bfcb73d276ecca13c3adf95F2278C40'

  Scenario: Create a Board and Get the Board
    #Creating a Board
    Given path '/1/boards/'
    And param key = keyVal
    And param token = tokenVal
    And param name = 'Karate-Framework'
    When method POST
    Then status 200
    And print response
    And def boardCreated = response
    And match $.name == 'Karate-Framework'
    #Getting the board
    Given path '/1/boards/', boardCreated.id
    And param key = keyVal
    And param token = tokenVal
    When method GET
    Then status 200
    And print response
