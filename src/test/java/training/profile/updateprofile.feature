Feature:  Update profile

  Background:
    * url url

  @flow
  Scenario Outline:  Update profile
    * def updateProfile = {"user":{"username":'<username>',"email":'<email>',"bio":'<bio>',"image":'<imagenUrl>'}}
    * def profileSuccessfully = read('training/profile/userscheme.json')

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
    And assert getProfile.response.user.username === response.user.username

    Examples:
    |username        |email                     |bio           |imagenUrl          |statusCode|
    |migueyliuiyles  |migueeys@gmail.com        |soy estudiante|imagen.png         |200       |
    |elvismg         |elvismg+7@gmail.com       |soy estudiante|imagen.png         |200       |

  @unitTest
  Scenario Outline:  Update wrong profile
    * def updateProfile = {"user":{"username":'<username>',"email":'<email>',"bio":'<bio>',"image":'<imagenUrl>'}}
    * def profileIncorrect = read('training/profile/userincorrectschema.json')

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
