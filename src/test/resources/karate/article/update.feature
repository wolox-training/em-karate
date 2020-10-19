Feature: update an article

  Background:
    * url url
    * def getArticles = call read('classpath:karate/article/getArticle.feature@getAllArticles')
    * def randomArticle = read('classpath:karate/helpers/Random.js')
    * def slug = randomArticle(getArticles.response.articles).slug

  @flow
  Scenario Outline: update an article
    * def updateArticle = {"article":{"title":'<updateTitle>', "description":'<updateDescription>', "body":'<updateDescriptionbody>', "tagList":[]}}
    * def articleSuccessfully = read('classpath:karate/article/responsearticle.json')

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
    And def getArticle = call read('getArticle.feature@getArticle'){ passedSlug: '#(slug)' }
    And match getArticle.response == response
    And  assert getArticle.response.article.title == '<updateTitle>'
    And  assert getArticle.response.article.description == '<updateDescription>'
    And  assert getArticle.response.article.body == '<updateDescriptionbody>'

    Examples:
       |statusCode|updateTitle          |updateDescription |updateDescriptionbody|
       |200       |Trainig  dllo        |NODE js           |With project         |
       |200       |Trainig  QA          |Automation        |Automation With      |
