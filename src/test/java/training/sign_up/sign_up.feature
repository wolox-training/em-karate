Feature: Register a new user

  Background:
    * url url
    * def username = username
    * def email = email
    * def password = password
    * def usernameIncorrect = usernameIncorrect
    * def emailIncorrect = emailIncorrect
    * def passwordIncorrect = passwordIncorrect


  @flow
  Scenario: Register and login successfully

    * def register = { user: { username: '#(username)', email: '#(email)', password: '#(password)'} }
    * def registerSuccessfully = read('training/sign_up/registrationresponse.json')

    Given path 'users'
    And request register
    When method post
    Then status 200
    And match  response == registerSuccessfully
    And assert response.user.username == username
    And assert response.user.email == email
    And call login = read('../sign_in/sign_in.feature@loginSuccessfully'){ email: '#(email)', password:'#(password)' }

  @unitTest
  Scenario Outline: Register incorrect

    * def registerIncorrect = { user: { username: '#(<descriptionUsername>)', email: '#(<descriptionEmail>)', password: '#(<descriptionPassword>)'} }
    * def incorrectRegister = {"errors": {"username": <descriptionMessageUsername>,"email": <descriptionMessageEmail>, "password": <descriptionMessagePassword> }}
    * def registerIncorrect = read('training/sign_up/incorrectResponse.json')

    Given path 'users'
    And request registerIncorrect
    When method post
    Then status <statusCode>
     And match  response == registerIncorrect
     And assert response.errors.username == '<descriptionMessageUsername>'
     And assert response.errors.email == '<descriptionMessageEmail>'

    Examples:
      | descriptionUsername     | descriptionEmail   |   descriptionPassword    |statusCode|descriptionMessageUsername  |descriptionMessageEmail     |descriptionMessagePassword      |
      |username                 |  email             |     passwordIncorrect    |422       |is already taken.           |is already taken.           | minimum 8 characters           |
      |                         |  email             |     passwordIncorrect    |422       |is invalid                  |is already taken.           | minimum 8 characters           |
      |username                 |                    |     passwordIncorrect    |422       |is already taken.           |is invalid                  | minimum 8 characters           |
      |                         |                    |     passwordIncorrect    |422       |is invalid                  |is invalid                  | minimum 8 characters           |
      |username                 |  email             |                          |422       |is already taken.           |is already taken.           | can't be blank                 |
      |                         |                    |                          |422       |is invalid                  |is invalid                  | can't be blank                 |
      |                         |                    |                          |422       |is invalid                  |is invalid                  | can't be blank                 |
      |usernameIncorrect        |  emailIncorrect    |     passwordIncorrect    |422       |is invalid                  |is invalid                  | is invalid                     |
