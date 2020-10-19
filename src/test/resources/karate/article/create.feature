Feature: Create an article

  Background:
    * url url

  @flow
  Scenario Outline: create an article

    * def createArticle = {"article": {"title": '<descriptionTitle>',"description": '<description>',"body": '<descriptionbody>',"tagList": ["string"]}}
    * def articleSuccessfully = read('responsearticle.json')

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
    And def getArticle = call read('classpath:karate/article/getArticle.feature@getArticle'){ slug: '#(response.article.slug)' }
    And assert getArticle.response.article.slug === response.article.slug
    And assert getArticle.response.article.author.username === username

    Examples:

      | descriptionTitle      | description      |   descriptionbody    |statusCode|
      | Training  Qa          |Studying Karate   |Training              |200       |
      | Training de Dllo      |Studying Node js  |Training              |200       |
