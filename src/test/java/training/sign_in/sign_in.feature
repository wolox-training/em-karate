Feature: Login to Conduit

  Background:
    * url url
    * def username = username
    * def email = email
    * def password = password
    * def emailNotExist = emailNotExist
    * def passwordIncorrect = passwordIncorrect

  @loginSuccessfully
  Scenario: Login successfully

    * def login = {"user": {"email": '#(email)',"password": '#(password)'}}
    * def loginSuccessfully = read('training/sign_in/responsesuccessfully.json')

    Given path 'users', 'login'
    And request login
    When method post
    Then status 200
    And match  response == loginSuccessfully
    And assert response.user.username == username
    And assert response.user.email == email


  @unitTest
  Scenario Outline: login incorrect

    * def loginIncorrect = {"user": {"email": '#(<descriptionEmail>)',"password": '#(<descriptionPassword>)'}}
    * def responseIncorrect = read('training/sign_in/responseincorrect.json')

    Given path 'users', 'login'
    And request loginIncorrect
    When method post
    Then status <statusCode>
    And match  response == responseIncorrect
    And match response.errors['email or password'] contains '<descriptionMessage>'

    Examples:
       | descriptionEmail   |   descriptionPassword    |statusCode|descriptionMessage |
       |  emailNotExist     |password                  |422       |is invalid         |
       |  email             |passwordIncorrect         |422       |is invalid         |
       |                    |                          |422       |is invalid         |
