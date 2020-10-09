Feature: Create an article

  Background:
    * url url
    * def login = call read('../sign_in/sign_in.feature@loginSuccessfully')
    * def username = username
    * def token = "Bearer " + login.response.user.token

  @flow
  Scenario Outline: create an article

    * def createArticle = {"article": {"title": '<descriptionTitle>',"description": '<description>',"body": '<descriptionbody>',"tagList": ["string"]}}
    * def articleSuccessfully = read('training/article/responsesuccessfully.json')

    Given path 'articles'
    And header Authorization = token
    And request createArticle
    When method post
    Then status <statusCode>
    And match  response == articleSuccessfully
    And assert response.article.title == '<descriptionTitle>'
    And assert response.article.description == '<description>'
    And assert response.article.body == '<descriptionbody>'
    And assert response.article.author.username == username
    * def slug = response.article.slug
    * def getArticle = call read('getArticle.feature@getArticle'){ passedSlug: '#(slug)' }
    And assert getArticle.response.article.slug === slug
    And assert getArticle.response.article.author.username === username

    Examples:

      | descriptionTitle      | description      |   descriptionbody    |statusCode|
      | Training  Qa          |Studying Karate   |Training              |200       |
      | Training de Dllo      |Studying Node js  |Training              |200       |
