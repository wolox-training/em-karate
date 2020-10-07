function fn() {    
  var env = karate.env;
  var properties = read('classpath:karate-properties.json');
  if (!env) {
    env = 'dev';
  }
  return properties[env];
}
