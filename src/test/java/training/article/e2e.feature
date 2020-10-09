Feature: E2E  article

  Background:
    * def login = call read('../sign_in/sign_in.feature@loginSuccessfully')

  @e2eArticle
  Scenario: E2E  article

    * def createArticle = call read('create.feature@flow')
    * def updateArticle = call read('update.feature@flow'){ passedSlug: '#(createArticle.response.article.slug)' }
