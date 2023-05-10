Feature: Trello API

  Background: 
    * url 'https://api.trello.com'
    * header Accept = 'application/json'
    * def keyVal = 'd331c6d0306950ea15c1be8870875a60'
    * def tokenVal = 'ATTA1a7971bfbd25f0320bc6fdd8b8467298dcba14ce3bfcb73d276ecca13c3adf95F2278C40'

    Scenario Outline: Archive lists
    #Getting all the boards
    Given path '/1/members/me/boards'
    And param key = keyVal
    And param token = tokenVal
    When method GET
    Then status 200
    And print response
    And def allBoards = response
    #Getting the lists on board
    Given path '/1/boards/', allBoards[0].id, '/lists'
    And param key = keyVal
    And param token = tokenVal
    When method GET
    Then status 200
    And print response
    And def allLists = response
    #Archive the lists
    Given path '/1/lists/', <ids>, '/closed'
    And param value = 'true'
    And param key = keyVal
    And param token = tokenVal
    When method PUT
    Then status 200
    And print response
    Examples:
    |ids|
    |allLists[0].id|
    |allLists[0].id|
    |allLists[0].id|