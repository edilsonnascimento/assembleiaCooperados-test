Feature: Endpoint for Bucket creation

  Scenario: Test POST creat Pauta
    * def pauta =
          """
              {
                "uuid": "1bf315dc-9f15-4da1-9ade-33388ac0b636",
                "titulo": "titulo",
                "descricao": "descricao"
              }
          """
  Given url 'http://localhost:8080'
  And path 'v1/pautas'
  And request pauta
  When method POST
  Then status 201