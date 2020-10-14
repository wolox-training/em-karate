Feature:  get profile

  Background:
    * url url

  @getprofile
  Scenario:  get profile

    * def responseGet = read('training/profile/userschema.json')

    Given path 'user'
    And header Authorization = token
    When method get
    Then status 200
    And match  response == responseGet
    And assert response.user.username == username
    And assert response.user.token == token
