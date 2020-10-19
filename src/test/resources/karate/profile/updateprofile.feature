Feature:  Update profile

  Background:
    * url url

  @flow
  Scenario Outline:  Update profile
    * def updateProfile = {"user":{"bio":'<bio>',"image":'<imagenUrl>'}}

    Given path 'user'
    And header Authorization = token
    And request updateProfile
    When method put
    Then status <statusCode>
    And assert response.user.bio == '<bio>'
    And assert response.user.image == '<imagenUrl>'
    And def getProfile = call read('classpath:karate/profile/getprofile.feature@getprofile'){ username: '#(response.user.username)' }
    And assert getProfile.response.user.image == '<imagenUrl>'
    And assert getProfile.response.user.bio == '<bio>'

    Examples:
      |bio           |imagenUrl                 |statusCode|
      |aprendiendo   |elvis.png                 |200       |
      |trainnig      |els.png                 |200       |


  @unitTest
  Scenario Outline:  Update wrong profile
    * def updateProfile = {"user":{"username":'<username>',"email":'<email>',"bio":'<bio>',"image":'<imagenUrl>'}}
    * def profileIncorrect = read('userincorrectschema.json')

    Given path 'user'
    And header Authorization = token
    And request updateProfile
    When method put
    Then status <statusCode>
    And match  response == profileIncorrect

    Examples:
      |username        |email                     |bio           |imagenUrl          |statusCode|
      |                |migueeys@gmail.com        |soy estudiante|imagen.png         |422       |
      |elvismg         |                          |soy estudiante|imagen.png         |422       |
      |elvismg         |elvismg                   |soy estudiante|imagen.png         |422       |
