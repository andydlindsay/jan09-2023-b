const express = require('express');
const morgan = require('morgan');
const cookieSession = require('cookie-session');

const bcrypt = require('bcryptjs');

const app = express();
const port = process.env.PORT || 8080;

// // middleware
app.use(express.urlencoded({ extended: false }));
app.use(morgan('dev'));
app.use(express.static('public'));
app.use(cookieSession({
  name: "lecture",
  keys: ["fh2ht89gjs9gfe7iwhfui32h7fiwadyaf", "fhuiafgdr51635ytagGDYAF79A8DFDA"]
}));

app.use((req, res, next) => {
  console.log('monkeyfuzz!');
  next();
});

app.set('view engine', 'ejs');

// user database
const users = {
  jstamos: {
    username: 'jstamos',
    password: '$2b$10$7bOWn.DFgs9HkhzsTpuD1u6pReqRouddq.rO5xSKdWMZGXRehkS8e'
  },
  alice: {
    username: 'alice',
    password: '5678'
  }
};

// GET routes

app.get('/login', (req, res) => {
  res.render('login');
});

app.get('/register', (req, res) => {
  res.render('register');
});

app.get('/protected', (req, res) => {
  const username = req.session.username;

  if (!username) {
    return res.redirect('/login');
  }

  const user = users[username];
  if (!user) {
    return res.redirect('/register');
  }

  console.log('users:', users);
  res.render('protected', { user });
});

app.get('*', (req, res) => {
  res.redirect('/login');
});

// // POST routes
app.post('/login', (req, res) => {
  const username = req.body.username;
  const password = req.body.password;

  const user = users[username];
  if (!user) {
    return res.status(401).send('No user with that username found');
  }

  bcrypt.compare(password, user.password)
  .then((result) => {
    console.log('do the passwords match?', result);
    if (result) {
      console.log('logging user in');
      req.session.username = user.username;
      res.redirect('/protected');
    } else {
      return res.status(401).send('Password incorrect');
    }
  });

});

app.post('/register', (req, res) => {
  const username = req.body.username;
  const password = req.body.password;

  bcrypt.genSalt(10)
    .then((salt) => {
      return bcrypt.hash(password, salt);
    })
    .then((hash) => {
      console.log('hash', hash);
      users[username] = {
        username,
        password: hash // THIS line is the way to do with with integrity. THIS is the right way to do this.
      };
    });

  console.log(users);
  res.redirect('/login');
});

app.post('/logout', (req, res) => {
  req.session = null;
  res.redirect('/login');
});

app.listen(port, () => {
  console.log(`server listening on port ${port}`);
});
