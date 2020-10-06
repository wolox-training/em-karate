Feature: Register a new user

  Background:
    * url someUrl
    * def stream = read('classpath:karate.properties')
    * def properties = new java.util.Properties()
    * eval properties.load(stream)

  Scenario Outline: Register successfully


    * def username = properties.username
    * def email = properties.email
    * def password = properties.password
    * def register = { user: { username: '#(<username>)', email: '#(<email>)', password: '#(<password>)'} }

    * def registerSuccessfully = read('training/sign_up/json/successfulregistrationresponse.json')
    Given path 'users'
    And request register
    When method post
    Then status <statusCode>
    And match  response == registerSuccessfully


    Examples:
      | username                | email  | password                 |statusCode|
      |   username              |  email |   password               |201       |


  Scenario Outline: Register incorrect

    * def username = properties.username
    * def email = properties.email
    * def password = properties.password
    * def registerIncorrect = { user: { username: '#(<username>)', email: '#(<email>)', password: '#(<password>)'} }
    * def incorrectRegister = {"errors": {"username": <messageUsername>,"email": <messageEmail>}}

    Given path 'users'
    And request registerIncorrect
    When method post
    Then status <statusCode>
    And match incorrectRegister contains {"errors": {"username": <messageUsername>,"email": <messageEmail>}}

    Examples:
      | username                | email              |   password               |statusCode|messageUsername  |messageEmail     |messagePassword      |
      |username                 |  email             |     password             |422       |is already taken.|is already taken.| minimum 8 characters|
      |                         |  email             |     password             |422       |can't be blank   |                 | minimum 8 characters|
      |username                 |                    |     password             |422       |                 |can't be blank   | minimum 8 characters|
      |                         |                    |     password             |422       |can't be blank   |can't be blank   | minimum 8 characters|
      |username                 |  email             |                          |422       |                 |                 | can't be blank      |
      |                         |                    |                          |422       |can't be blank   |can't be blank   | can't be blank      |
      |                         |                    |                          |422       |can't be blank   |can't be blank   | can't be blank      |

  Scenario Outline: Data validation register

    * def usernameIncorrect = properties.usernameIncorrect
    * def emailIncorrect = properties.emailIncorrect
    * def passwordIncorrect = properties.passwordIncorrect
    * def registerIncorrectValidate = { user: { username: '#(<usernameIncorrect>)', email: '#(<emailIncorrect>)', password: '#(<passwordIncorrect>)'} }
    * def incorrecValidate = {"errors": {"username": <messageUsername>,"email": <messageEmail>}}

    Given path 'users'
    And request registerIncorrectValidate
    When method post
    Then status <statusCode>
    And match incorrecValidate contains {"errors": {"username": <messageUsername>,"email": <messageEmail>}}

    Examples:
      | usernameIncorrect                | emailIncorrect              |   passwordIncorrect               |statusCode|messageUsername  |messageEmail     |messagePassword|
      |usernameIncorrect                 |  emailIncorrect             |     passwordIncorrect             |422       |is invalid       |is invalid       | is invalid    |
