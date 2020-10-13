function fn() {    
  var env = karate.env;
  var properties = read('classpath:karate-properties.json');
  if (!env) {
    env = 'dev';
  }
  var login = karate.callSingle('classpath:training/sign_in/sign_in.feature@loginSuccessfully', properties[env]);
  var config = properties[env];
  config.token = "Bearer " + login.response.user.token;
  return config;
}
