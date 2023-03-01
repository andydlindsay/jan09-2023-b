const auth = require('basic-auth');

const admin = { name: 'username', password: 'password' };

// get users object from JSON in file
const users = require('./.env.json');

module.exports = function (request, response, next) {
  // var user = auth(request); // user will be like this Credentials { name: 'username', pass: 'password' }
  const user = {"name": "admin", "pass": "fuzzymonkey"};
  console.log('user',user);
  console.log('users', users);
  // if (!user || !user.name || !users[user.name] || users[user.name].password !== user.pass) {
  //   response.set('WWW-Authenticate', 'Basic realm="example"');
  //   return response.status(401).send();
  // }
  delete user.pass;
  request.session.credentials = {...users[user.name], password: '12345'};
  console.log('request.session.credentials', request.session.credentials);
  return next();
}
