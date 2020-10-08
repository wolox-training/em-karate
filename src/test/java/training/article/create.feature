Feature: Create an article

  Background:
    * url url
    * def login = call read('../sign_in/sign_in.feature@loginSuccessfully')
    * def username = username

    * def token = "Bearer " + login.response.user.token

  @createSuccessfully
  Scenario Outline: create an article

    * def createArticle = {"article": {"title": '#(<descriptionTitle>)',"description": '#(<description>)',"body": '#(<descriptionbody>)',"tagList": ["string"]}}
    * def articleSuccessfully = read('training/article/responsesuccessfully.json')

    Given path 'articles'
    And header Authorization = token
    And request createArticle
    When method post
    Then status <statusCode>
    And match  response == articleSuccessfully
    And match response.article.title contains '<descriptionTitle>'
    And match response.article.description contains '<description>'
    And match response.article.body contains '<descriptionbody>'
    And match response.article.author.username contains username
    * def slug = response.article.slug

    Given path 'articles',slug
    When method get
    Then status <statusCode>
    And assert response.article.slug === slug
    And assert response.article.author.username === username

    Examples:

      | descriptionTitle      | description      |   descriptionbody    |statusCode|
      | Training  Qa          |Studying Karate   |Training              |200       |
      | Training de Dllo      |Studying Node js  |Training              |200       |
