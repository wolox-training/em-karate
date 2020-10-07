Feature: Enter the API

  Background:
    * url url
    * def email = email
    * def password = password
    * def emailNotExist = emailNotExist
    * def passwordIncorrect = passwordIncorrect

  @flowLogin
  Scenario: Login successfully

    * def login = {"user": {"email": '#(email)',"password": '#(password)'}}
    * def loginSuccessfully = read('training/sign_up/scheme/loginresponse.json')

    Given path 'users/login'
    And request login
    When method post
    Then status 200
    And match  response == loginSuccessfully
    And assert response.user.username == username
    And assert response.user.email == email

  @unitTestLogin
  Scenario Outline: login incorrect

    * def loginIncorrect = {"user": {"email": '#(<descriptionEmail>)',"password": '#(<descriptionPassword>)'}}
    * def incorrectLogin = {"errors": {"email or password": <descriptionMessage>}}

    Given path 'users/login'
    And request loginIncorrect
    When method post
    Then status <statusCode>

    Examples:
       | descriptionEmail   |   descriptionPassword    |statusCode|descriptionMessage |
       |  emailNotExist     |password                  |422       |is invalid         |
       |  email             |passwordIncorrect         |422       |is invalid         |
    