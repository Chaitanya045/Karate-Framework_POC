Feature: Trello API

  Background: 
    * url 'https://api.trello.com'
    * header Accept = 'application/json'
    * eval credentials = read('credentials.csv')

  @Test1
  Scenario Outline: Trello
    #Creating a Board
    Given path '/1/boards/'
    * def board = <boardName>
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    And param name = board
    When method POST
    Then status 200
    And print response
    And def boardCreated = response
    And match response.name == <boardName>
    #Getting the board
    Given path '/1/boards/', boardCreated.id
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    #Getting all the boards and selecting the relevant boardID
    Given path '/1/members/me/boards'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    When def boardId = 0
    Then eval for(var i=0; i<response.length; i++) if(response[i].name == <boardName>) boardId = response[i].id
    And print boardId
    #Getting the lists on board
    Given path '/1/boards/', boardId, '/lists'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    And def allLists = response
    #Archive the lists
    Given path '/1/lists/', allLists[0].id, '/closed'
    And param value = 'true'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method PUT
    Then status 200
    And match $.closed == true
    And print response
    Given path '/1/lists/', allLists[0].id, '/closed'
    And param value = 'true'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method PUT
    Then status 200
    And match $.closed == true
    Given path '/1/lists/', allLists[0].id, '/closed'
    And param value = 'true'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method PUT
    Then status 200
    And match $.closed == true
    #Creating Done list in the board
    Given path '/1/lists'
    And param idBoard = boardId
    And param name = 'Done'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method POST
    Then status 200
    And match $.name == 'Done'
    And print response
    #Creating To Do list in the board
    Given path '/1/lists'
    And param idBoard = boardId
    And param name = 'To Do'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method POST
    Then status 200
    And match $.name == 'To Do'
    And print response
    #Getting the lists on board
    Given path '/1/boards/', boardId, '/lists'
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method GET
    Then status 200
    And print response
    When def listId = null
    * def targetId = null
    Then eval for(var i=0; i<response.length; i++) if(response[i].name == "To Do") listId = response[i].id
    Then eval for(var i=0; i<response.length; i++) if(response[i].name == "Done") targetId = response[i].id
    #Move cards to the list
    Given path '/1/lists/', listId, '/moveAllCards'
    And param idBoard = boardId
    And param idList = targetId
    And param key = credentials[0].Key
    And param token = credentials[0].Token
    When method POST
    Then status 200
    And print response
    Examples:
    |read('data.csv')|

 