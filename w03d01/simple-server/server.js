const http = require('http');

const server = http.createServer();

// console.log(server);

// server.on('connection', (conn) => {});

// listen for an incoming request
server.on('request', (request, response) => {
  console.log(request.method, request.url);

  if (request.method === 'GET' && request.url === '/home') { // GET /home
    response.write('hello! welcome to the homepage!');
  } else if (request.method === 'GET' && request.url === '/products') {
    response.write('these are all the products!');
  } else {
    response.write('this is not the page you are looking for');
  }

  response.end();
});

server.listen(54321, () => {
  console.log('server is listening on port 54321');
});
