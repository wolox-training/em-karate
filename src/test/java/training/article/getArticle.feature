Feature:  get an article

  Background:
    * url url
    * def responseGetArticle = read('training/article/responsesuccessfully.json')

  @getArticle
  Scenario:  get an article

    * def getArticles = call read('getArticle.feature@getAllArticles')
    * def randomArticle = read('../helpers/Random.js')
    * def slug = typeof passedSlug == 'undefined' ? randomArticle(getArticles.response.articles).slug : passedSlug
    Given path 'articles', slug
    And header Authorization = token
    When method get
    Then status 200
    And match  response == responseGetArticle
    And assert response.article.slug == slug

  @getAllArticles
  Scenario:  get all articles

    Given path 'articles'
    And header Authorization = token
    When method get
    Then status 200
