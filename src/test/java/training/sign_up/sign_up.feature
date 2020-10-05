Feature: Register a new user

  Background:
    * url someUrl

  Scenario: Register successfully

    * def username = register.username
    * def email = register.email
    * def password = register.password
    * def register = { user: { username: '#(username)', email: '#(email)', password: '#(password)'} }

    * match  register.user contains {"username": '#notnull'}
    * match  register.user contains {"email": '#notnull'}
    * match  register.user contains {"password": '#notnull'}

    * assert  register.user.password.length >= 8
    * assert /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(register.user.email)

    * def registerSuccessfully = read('training/sign_up/json/successfulregistrationresponse.json')
    Given path 'users'
    And request register
    When method post
    Then status 200
    And match  response == registerSuccessfully
