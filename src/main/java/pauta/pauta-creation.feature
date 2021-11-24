Feature: Endpoint for Bucket creation

  Scenario: Test POST creat Pauta
    * def uuidRandom =
    """
      function() { return java.util.UUID.randomUUID() + ''}
    """

    * def numberRandom =
    """
        function(max) { return Math.floor(Math.random() * max) }
    """

    * def pauta =
          """
              {
                "uuid": '#(uuidRandom())',
                "titulo": '#("Título - " + numberRandom(1000))',
                "descricao": "descricao"
              }
          """
  Given url 'http://localhost:8080'
  And path 'v1/pautas'
  And request pauta
  When method POST
  Then status 201