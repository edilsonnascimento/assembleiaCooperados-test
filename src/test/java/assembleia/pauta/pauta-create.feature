Feature: Endpoint for Bucket creation

  Background:
    * url 'http://localhost:8080/v1/pautas'
    * def gererate = Java.type('assembleia.DataGenerator')

  Scenario: Create Bucket with valid

    Given request
            """
                {
                  "uuid": '#(gererate.uuid())',
                  "titulo": '#("Título - " + gererate.randomName())',
                  "descricao": '#("Descrição - " + gererate.randomName())',
                }
            """

    When method POST
    Then status 201


  Scenario Outline: Can't create Bucket with invalid

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
      | uuid               | titulo                        | descricao
      | #(gererate.uuid()) | #("Título - " + randomName()) | ''
      | #(gererate.uuid()) | 'ABC'                         | #("Descricao - " + randomName())
      | null               | #("Título - " + randomName()) | #("Descricao - " + randomName())


