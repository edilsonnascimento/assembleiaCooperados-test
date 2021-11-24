Feature: Endpoint for Bucket creation

  Background:
    * url 'http://localhost:8080/v1/pautas'

  Scenario: Create Bucket with valid

      * def uuidRandom = function() { return java.util.UUID.randomUUID() + ''}
      * def numberRandom = function(max) { return Math.floor(Math.random() * max) }

      Given request
            """
                {
                  "uuid": '#(uuidRandom())',
                  "titulo": '#("Título - " + numberRandom(1000))',
                  "descricao": "descricao"
                }
            """
      When method POST
      Then status 201

  Scenario Outline: Can't create Bucket with invalid

    * def uuidRandom = function() { return java.util.UUID.randomUUID() + ''}
    * def numberRandom = function(max) { return Math.floor(Math.random() * max) }

    Given request
            """
                {
                  "uuid": <uuid>,
                  "titulo": <titulo>,
                  "descricao": <descricao>
                }
            """
    When method POST
    Then status 400
    Examples:
      | uuid           | titulo                              | descricao
      | #(uuidRandom()) | #("Título - " + numberRandom(1000)) | 'Mesma descrição'

