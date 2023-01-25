const express = require('express');
const morgan = require('morgan');
const cookieParser = require('cookie-parser');
const languages = require('./languages.json'); // JSON.parse()

const app = express();
const port = 7654;

// database
const users = {
  abc: {
    id: 'abc',
    username: 'alice',
    password: '1234'
  }
};

// configuration
app.set('view engine', 'ejs');

// middleware
app.use(morgan('dev'));
app.use(cookieParser()); // populates req.cookies
app.use(express.urlencoded({ extended: false })); // populates req.body

// GET /login
app.get('/login', (req, res) => {
  res.render('login');
});

// POST /login
app.post('/login', (req, res) => {
  console.log(req.body);
  // get the username and password off of req.body
  const username = req.body.username;
  const password = req.body.password;

  // what if they didn't give us a username and/or a password
  if (!username || !password) {
    return res.status(400).send('please provide a username and a password');
  }

  // find a user based off of the username
  let foundUser = null;
  for (const userId in users) {
    const user = users[userId];
    if (user.username === username) {
      // we found the user!
      foundUser = user;
    }
  }

  // check if we didn't find a user
  if (!foundUser) {
    return res.status(400).send('no user with that username found');
  }

  // do the passwords NOT match?
  if (foundUser.password !== password) {
    return res.status(400).send('the passwords do not match');
  }

  // hooray! They are who they say they are!
  // set a cookie
  res.cookie('userId', foundUser.id);

  // send the user somewhere (POST REDIRECT GET)
  res.redirect('/protected');
});

// GET /register
app.get('/register', (req, res) => {
  res.render('register');
});

// POST /register
app.post('/register', (req, res) => {
  const username = req.body.username;
  const password = req.body.password;

  // check if they didn't give us a username OR a password
  if (!username || !password) {
    return res.status(400).send('please provide a username and a password');
  }

  // create a new user object
  const id = Math.random().toString(36).substring(2, 5);
  const newUser = {
    id: id,
    username: username,
    password: password
  };

  users[id] = newUser;
  console.log(users);

  // do we log the user in??
  // res.redirect('/login');

  res.cookie('userId', newUser.id);
  res.redirect('/protected');
});

// GET /protected
app.get('/protected', (req, res) => {
  // check if the user does not have a userId cookie
  // console.log(req.cookies);
  const userId = req.cookies.userId;

  if (!userId) {
    return res.status(401).send('you must be logged in to see this page');
  }

  // find the user based off their id
  const user = users[userId]; // users['abc']

  const templateVars = {
    username: user.username
  };

  res.render('protected', templateVars);
});

// POST /logout
app.post('/logout', (req, res) => {
  res.clearCookie('userId');
  res.redirect('/login');
});

// GET /home
app.get('/home', (req, res) => {
  console.log(req.cookies);
  const languagePref = req.cookies.languagePref;

  const templateVars = {
    heading: languages.homeHeadings[languagePref],
    body: languages.homeBodies[languagePref]
  };

  // console.log(templateVars);
  res.render('home', templateVars);
});

// GET /about
app.get('/about', (req, res) => {
  const languagePref = req.cookies.languagePref;

  const templateVars = {
    heading: languages.aboutHeadings[languagePref],
    body: languages.aboutBodies[languagePref]
  };
  res.render('about', templateVars);
});

// GET /languages/:languagePref (eg. "/languages/es")
app.get('/languages/:languagePref', (req, res) => {
  // get the client's language of choice
  const languagePref = req.params.languagePref;

  // set a cookie
  res.cookie('languagePref', languagePref);

  // send the user somewhere
  res.redirect('/home');
});

app.listen(port, () => {
  console.log(`app is listening on port ${port}`);
});
