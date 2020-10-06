Feature: Register a new user

  Background:
    * url url
    * def username = username
    * def email = email
    * def password = password
    * def usernameIncorrect = usernameIncorrect
    * def emailIncorrect = emailIncorrect
    * def passwordIncorrect = passwordIncorrect

  @flowRegister
  Scenario: Register successfully

    * def register = { user: { username: '#(username)', email: '#(email)', password: '#(password)'} }
    * def registerSuccessfully = read('training/sign_up/scheme/registrationresponse.json')

    Given path 'users'
    And request register
    When method post
    Then status 200
    And match  response == registerSuccessfully


   @unitTestRegister
  Scenario Outline: Register incorrect

    * def registerIncorrect = { user: { username: '#(<descriptionUsername>)', email: '#(<descriptionEmail>)', password: '#(<descriptionPassword>)'} }
    * def incorrectRegister = {"errors": {"username": <descriptionMessageUsername>,"email": <descriptionMessageEmail>}}

    Given path 'users'
    And request registerIncorrect
    When method post
    Then status <statusCode>


    Examples:
      | descriptionUsername     | descriptionEmail   |   descriptionPassword    |statusCode|descriptionMessageUsername  |descriptionMessageEmail     |descriptionMessagePassword      |
      |username                 |  email             |     password             |422       |is already taken.           |is already taken.           | minimum 8 characters           |
      |                         |  email             |     password             |422       |can't be blank              |                            | minimum 8 characters           |
      |username                 |                    |     password             |422       |                            |can't be blank              | minimum 8 characters           |
      |                         |                    |     password             |422       |can't be blank              |can't be blank              | minimum 8 characters           |
      |username                 |  email             |                          |422       |                            |                            | can't be blank                 |
      |                         |                    |                          |422       |can't be blank              |can't be blank              | can't be blank                 |
      |                         |                    |                          |422       |can't be blank              |can't be blank              | can't be blank                 |
      |usernameIncorrect        |  emailIncorrect    |     passwordIncorrect    |422       |is invalid                  |is invalid                  | is invalid                     |


