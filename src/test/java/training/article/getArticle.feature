Feature:  get an article

  Background:
    * url url
    * def responseGetArticle = read('training/article/responsesuccessfully.json')

  @getArticle
  Scenario:  get an article

    * def slug = passedSlug

    Given path 'articles', slug
    And header Authorization = token
    When method get
    Then status 200
    And match  response == responseGetArticle
    And assert response.article.slug == slug

  @getAllArticles
  Scenario:  get all articles

    * def responseGetArticles = read('training/article/responsearticles.json')
    * def responseGetArticle = read('training/article/responsearticle.json')

    Given path 'articles'
    And header Authorization = token
    When method get
    Then status 200
    And match  response == responseGetArticles
    And match each response.articles == responseGetArticle
    And assert response.articles.length == response.articlesCount
