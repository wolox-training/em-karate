function fn() {    
  var env = karate.env;
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    someUrl: 'https://angular-conduit-node.herokuapp.com/api',

  }
  if (env == 'dev') {

  } else if (env == 'e2e') {

  }
  return config;
}
