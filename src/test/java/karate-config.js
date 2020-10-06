function fn() {    
  var env = karate.env;
  var properties = read('classpath:karate-properties.json');
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    someUrl: 'https://angular-conduit-node.herokuapp.com/api',
    properties: properties
  }
  return config;
}
