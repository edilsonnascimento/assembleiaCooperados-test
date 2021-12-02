Feature: Endpoint for Bucket creation

  Background:
    * url 'http://localhost:8080/v1/pautas'
    * def generate = Java.type('assembleia.DataGenerator')

  Scenario: Must create only one Bucket with same valid field
      * def uuid = generate.uuid()
      * def titulo =  "Título - " + generate.randomName()
      * def expetedLocation = 'v1/pautas/' + uuid
      * def payload =
            """
                  {
                    "uuid": '#(uuid)',
                    "titulo": '#(titulo)',
                    "descricao": '#("Descrição - " + generate.randomName())',
                  }
            """

      Given request payload
      When method POST
      Then status 201
      And match responseHeaders['Location'][0] == expetedLocation

      Given request payload
      When method POST
      Then status 400
      And match response == { message: 'Invalid duplicated data', uuid: '#(uuid)', titulo: '#(titulo)' }


  Scenario Outline: Can't create Bucket with invalid fields
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
        | uuid               | titulo                                 | descricao                                 |
        | #(generate.uuid()) | #("Título - " + generate.randomName()) | ''                                        |
        | #(generate.uuid()) | #("Título - " + generate.randomName()) | null                                      |
        | #(generate.uuid()) | 'ABC'                                  | #("Descricao - " + generate.randomName()) |
        | #(generate.uuid()) | ''                                     | #("Descricao - " + generate.randomName()) |
        | #(generate.uuid()) | null                                   | #("Descricao - " + generate.randomName()) |
        | #(generate.uuid()) |                                        | #("Descricao - " + generate.randomName()) |
        | null               | #("Título - " + generate.randomName()) | #("Descricao - " + generate.randomName()) |
        | ''                 | #("Título - " + generate.randomName()) | #("Descricao - " + generate.randomName()) |
        |                    | #("Título - " + generate.randomName()) | #("Descricao - " + generate.randomName()) |