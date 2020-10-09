Feature:  get all articles

  Background:
    * url url
    * def login = call read('../sign_in/sign_in.feature@loginSuccessfully')
    * def token = "Bearer " + login.response.user.token


  @getArticles
  Scenario:  get all articles
    Given path 'articles'
    And header Authorization = token
    When method get
    Then status 200
    