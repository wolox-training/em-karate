Feature: update an article

  Background:
    * url url
    * def username = username
    * def getArticles = call read('getArticle.feature@getAllArticles')
    * def randomArticle = read('../helpers/Random.js')
    * def slug = typeof passedSlug == 'undefined' ? randomArticle(getArticles.response.articles).slug : passedSlug

  @flow
  Scenario Outline: update an article
    * def updateArticle = {"article":{"title":'<updateTitle>', "description":'<updateDescription>', "body":'<updateDescriptionbody>', "tagList":["dragons","training"]}}
    * def articleSuccessfully = read('training/article/responsesuccessfully.json')

    Given path 'articles', slug
    And header Authorization = token
    And request updateArticle
    When method put
    Then status <statusCode>
    And match  response == articleSuccessfully
    And assert response.article.title == '<updateTitle>'
    And assert response.article.description == '<updateDescription>'
    And assert response.article.body == '<updateDescriptionbody>'
    And assert response.article.author.username == username
    * def responseUpdate = response
    * def getArticle = call read('getArticle.feature@getArticle'){ passedSlug: '#(slug)' }
    And match getArticle.response == responseUpdate

    Examples:
       |statusCode|updateTitle          |updateDescription |updateDescriptionbody|
       |200       |Training  dllo       |NODE js           |With project         |
       |200       |Training  QA         |Performance Jmeter|With project         |
