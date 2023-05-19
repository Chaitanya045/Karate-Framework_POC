Feature: Trello API

  Background: 
    * url 'https://api.trello.com'
    * header Accept = 'application/json'
    * eval credentials = read('credentials.csv')
	
  Scenario: Create a Board and Get the Board
    #Creating a Board
    Given path '/1/boards/'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    And param name = 'Karate-Framework'
    When method POST
    Then status 200
    And print response
    And def boardCreated = response
    And match $.name == 'Karate-Framework'
    #Getting the board
    Given path '/1/boards/', boardCreated.id
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    
    Scenario Outline: Archive lists
    #Getting all the boards
    Given path '/1/members/me/boards'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    And def allBoards = response
    #Getting the lists on board
    Given path '/1/boards/', allBoards[0].id, '/lists'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    And def allLists = response
    #Archive the lists
    Given path '/1/lists/', <ids>, '/closed'
    And param value = 'true'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method PUT
    Then status 200
    And match $.closed == true
    And print response
    Examples:
    |ids|
    |allLists[0].id|
    |allLists[0].id|
    |allLists[0].id|
    
    Scenario: Create lists in board
    #Getting all the boards
    Given path '/1/members/me/boards'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    And def allBoards = response
    #Getting all the lists in the board
    Given path '/1/boards/', allBoards[0].id, '/lists'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    #Creating Done list in the board
    Given path '/1/lists'
    And param idBoard = allBoards[0].id
    And param name = 'Done'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method POST
    Then status 200
    And match $.name == 'Done'
    And print response
    #Getting all the lists in the board
    Given path '/1/boards/', allBoards[0].id, '/lists'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    #Creating To Do list in the board
    Given path '/1/lists'
    And param idBoard = allBoards[0].id
    And param name = 'To Do'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method POST
    Then status 200
    And match $.name == 'To Do'
    And print response
    
    Scenario: Create a new card
    #Getting all the boards
    Given path '/1/members/me/boards'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    And def allBoards = response
    #Getting the lists on board
    Given path '/1/boards/', allBoards[0].id, '/lists'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    And def allLists = response
    #Creating a new card in a list
    Given path '/1/cards'
    And param idList = allLists[0].id
    And param name = 'Practice Karate-Framework'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method POST
    Then status 200
    And print response
    
    Scenario: Move cards to the list
    #Getting all the boards
    Given path '/1/members/me/boards'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    And def allBoards = response
    #Getting the lists on board
    Given path '/1/boards/', allBoards[0].id, '/lists'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    And def allLists = response
    #Move cards to the list
    Given path '/1/lists/', allLists[0].id, '/moveAllCards'
    And param idBoard = allBoards[0].id
    And param idList = allLists[1].id
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method POST
    Then status 200
    And print response