Feature: update an article

  Background:
    * url url
    * def login = call read('../sign_in/sign_in.feature@loginSuccessfully')
    * def username = username

    * def token = "Bearer " + login.response.user.token
    * def create = call read('create.feature@flow')
    * def slug = create.response.article.slug

  @flow
  Scenario Outline: update an article
    * def updateArticle = {"article":{"title":'#(<updateTitle>)', "description":'#(<updateDescription>)', "body":'#(<updateDescriptionbody>)', "tagList":["dragons","training"]}}
    * def articleSuccessfully = read('training/article/responsesuccessfully.json')

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
    Given path 'articles', 'training-de-dllo-36xhmh'
    And header Authorization = token
    When method get
    Then status <statusCode>
    And match response.article.title contains '<updateTitle>'
    And match response.article.description contains '<updateDescription>'
    And match response.article.body contains '<updateDescriptionbody>'
    And match response.article.author.username contains username

    Examples:
       |statusCode|updateTitle          |updateDescription |updateDescriptionbody|
       |200       |Training  dllo       |NODE js           |With project         |
       |200       |Training  QA         |Performance Jmeter|With project         |