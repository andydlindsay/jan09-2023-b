const express = require('express');
const morgan = require('morgan');

const app = express();
const port = 8000;

// middleware
// app.use((request, response, next) => {
//   console.log(request.method, request.url);

//   request.secretKey = 'hello world';

//   next();
// });
app.use(morgan('dev'));

// GET /home
app.get('/home', (request, response) => {
  // console.log('secret key', request.secretKey);

  if (true) {
    return response.send('this is the homepage of our app');
  }

  response.send('this is the homepage of our app');
});



// GET /about
app.get('/about', (req, res) => {
  res.send('all about us!');
});



app.listen(port, () => {
  console.log(`app is listening on port ${port}`);
});
