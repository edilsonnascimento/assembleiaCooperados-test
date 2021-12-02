Feature: Endpoint for list all Pautas

  Background:
    * url 'http://localhost:8080/v1/pautas'
    * def generate = Java.type('assembleia.DataGenerator')

  Scenario: Must create only one Bucket with same valid field
      * def uuid = generate.uuid()
      * def titulo =  "Título - " + generate.randomName()
      * def descricao = "Descrição - " + generate.randomName()
      * def expetedLocation = 'v1/pautas/' + uuid
      * def payload =
            """
                  {
                    "uuid": '#(uuid)',
                    "titulo": '#(titulo)',
                    "descricao": '#(descricao)',
                  }
            """

      Given request payload
      When method POST
      Then status 201
      And match responseHeaders['Location'][0] == expetedLocation

      When method GET
      Then status 200
      And match response contains
            """   {
                    "uuid": '#(uuid)',
                    "titulo": '#(titulo)',
                    "descricao": '#(descricao)',
                  }
            """
