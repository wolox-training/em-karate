Feature:  get an article

  Background:
    * url url


  @getArticle
  Scenario:  get an article
    * def responseGetArticle = read('classpath:karate/article/responsearticle.json')

    Given path 'articles', slug
    And header Authorization = token
    When method get
    Then status 200
    And match  response == responseGetArticle
    And assert response.article.slug == slug

  @getAllArticles
  Scenario:  get all articles

    * def responseGetArticles = read('classpath:karate/article/responsearticles.json')

    Given path 'articles'
    And header Authorization = token
    When method get
    Then status 200
    And match  response == responseGetArticles
