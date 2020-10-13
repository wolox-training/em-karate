Feature:  Update profile

  Background:
    * url url

  @flow
  Scenario Outline:  Update profile
    * def updateProfile = {"user":{"username":'<username>',"email":'<email>',"bio":'<bio>',"image":'<imagenUrl>'}}
    * def profileSuccessfully = read('training/profile/schemegetprofile.json')

    Given path 'user'
    And header Authorization = token
    And request updateProfile
    When method put
    Then status <statusCode>
    And match  response == profileSuccessfully
    And assert response.user.username == '<username>'
    And assert response.user.email == '<email>'
    And assert response.user.bio == '<bio>'
    And assert response.user.image == '<imagenUrl>'
    And def getProfile = call read('getprofile.feature@getprofile')
    And assert getProfile.response.user.username === response.user.'<username>'

    Examples:
    |username        |email                     |bio           |imagenUrl          |statusCode|
    |migueyliuiyles  |migueeysiuihf@gmail.com   |soy estudiante|imagen.png         |200       |
