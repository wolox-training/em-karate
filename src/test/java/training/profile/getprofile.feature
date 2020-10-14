Feature:  get profile

  Background:
    * url url
    * def username = username

  @getprofile
  Scenario:  get profile

    * def responseGet = read('training/profile/userscheme.json.json')

    Given path 'user'
    And header Authorization = token
    When method get
    Then status 200
    And assert response.user.username == username
    And match  response == responseGet
    And assert response.user.token == token
