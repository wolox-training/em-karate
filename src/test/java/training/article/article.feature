Feature: Create, edit and delete an article

  Background:
    * url url
    * def login = call read('../sign_in/sign_in.feature@loginSuccessfully')
    * def username = username

    * def token = "Bearer " + login.response.user.token

  Scenario Outline: E2E an article

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

    * def updateArticle = {"article":{"title":'#(<updateTitle>)', "description":'#(<updateDescription>)', "body":'#(<updateDescriptionbody>)', "tagList":["dragons","training"]}}
    * def slug = response.article.slug

    Given path 'articles', slug
    And header Authorization = token
    And request updateArticle
    When method put
    Then status <statusCode>
    And match  response == articleSuccessfully
    And match response.article.title contains '<updateTitle>'
    And match response.article.description contains '<updateDescription>'
    And match response.article.body contains '<updateDescriptionbody>'
    And match response.article.author.username contains username

    * def slugUpdate = response.article.slug

    Given path 'articles', slugUpdate
    And header Authorization = token
    When method delete
    Then status <statusCode>

    Examples:

      | descriptionTitle      | description      |   descriptionbody    |statusCode|updateTitle          |updateDescription |updateDescriptionbody|
      | Training  Qa          |Studying Karate   |Training              |200       |Training  dllo       |NODE js           |With project         |
      | Training de Dllo      |Studying Node js  |Training              |200       |Training  QA         |Performance Jmeter|With project         |
