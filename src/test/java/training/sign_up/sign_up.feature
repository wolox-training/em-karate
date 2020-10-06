Feature: Register a new user

  Background:
    * url someUrl
    * def stream = read('classpath:karate.properties')
    * def properties = new java.util.Properties()
    * eval properties.load(stream)
    * def username = properties.username
    * def email = properties.email
    * def password = properties.password
    * def usernameIncorrect = properties.usernameIncorrect
    * def emailIncorrect = properties.emailIncorrect
    * def passwordIncorrect = properties.passwordIncorrect

  @flowRegister
  Scenario: Register successfully

    * def register = { user: { username: '#(username)', email: '#(email)', password: '#(password)'} }
    * def registerSuccessfully = read('training/sign_up/json/successfulregistrationresponse.json')

    Given path 'users'
    And request register
    When method post
    Then status 201
    And match  response == registerSuccessfully

   @unitTestRegister
  Scenario Outline: Register incorrect

    * def registerIncorrect = { user: { username: '#(<descriptionUsername>)', email: '#(<descriptionEmail>)', password: '#(<descriptionPassword>)'} }
    * def incorrectRegister = {"errors": {"username": <descriptionMessageUsername>,"email": <descriptionMessageEmail>}}

    Given path 'users'
    And request registerIncorrect
    When method post
    Then status <statusCode>
    And match incorrectRegister contains {"errors": {"username": <descriptionMessageUsername>,"email": <descriptionMessageEmail>}}

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
