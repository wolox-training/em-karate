Feature: Create, edit and delete an article

  Background:
    * url url
    * def login = call read('../sign_in/sign_in.feature@loginSuccessfully')
    * def username = username
    * def token = "Bearer " + login.response.user.token

  @E2Earticle
  Scenario: E2E an article

    * def createArticle = call read('create.feature@flow')
    * def updateArticle = call read('update.feature@flow')