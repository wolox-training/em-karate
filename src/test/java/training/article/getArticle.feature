Feature:  get an article

  Background:
    * url url
    * def login = call read('../sign_in/sign_in.feature@loginSuccessfully')
    * def token = "Bearer " + login.response.user.token
    * def getArticles = call read('getAll.feature@getArticles')
    * def randomArticle = function(articles) { return articles[Math.floor(Math.random() * articles.length)] }
    * def slug = typeof passedSlug == 'undefined' ? randomArticle(getArticles.response.articles).slug : passedSlug

  @getArticle
  Scenario:  get an article

    Given path 'articles', slug
    And header Authorization = token
    When method get
    Then status 200
