const express = require('express');
const app = express();
const PORT = 8887;

app.set('view engine', 'ejs');

//
// MIDDLEWARE
//
app.use(express.urlencoded({extended: false}));

//
// DATABASE
//
const teams = {
  'oilers': {name: 'Edmonton Oilers', league: 'NHL'},
  'lions': {name: 'Detroit Lions', league: 'NFL'},
  'canucks': {name: 'Vancouver Canucks', league: 'NHL'},
};

//
// ROUTES
// BREAD => browse, read, edit, add, delete
//

//
// ADD
//
app.get('/team/add', (req, res) => {
  res.render('add');
});

app.post('/team/create', (req, res) => { // submit handler
  console.log('req.body', req.body);

  const slug = req.body.slug;
  const teamName = req.body.teamname;
  const league = req.body.league;

  teams[slug] = {name: teamName, league: league};

  res.redirect('/');
});

// BROWSE
app.get('/', (req, res) => {
  console.log('teams', teams);

  const teamNames = {};
  for (let name in teams) {
    // console.log('name', name);
    const teamName = teams[name].name;
    teamNames[name] = {name: teamName};
  }
  const templateVars = {
    teams: teamNames 
  };
  // console.log('templateVars', templateVars);
  res.render('home', templateVars);
});

//
// READ http://localhost:8887/team/oilers
//
app.get('/team/:name', (req, res) => {
  console.log('req.params', req.params);
  const teamName = req.params.name;

  const templateVars = {
    team: teams[teamName]
  };
  res.render('team', templateVars);
});

//
// EDIT
//
app.get('/team/edit/:slug', (req, res) => {
  const slug = req.params.slug;
  const templateVars = {
    slug: slug,
    team: teams[slug]
  };
  res.render('edit', templateVars);
});

app.post('/team/update', (req, res) => { // submit handler
  console.log('req.body', req.body);

  const slug = req.body.slug;
  const teamName = req.body.teamname;
  const league = req.body.league;

  teams[slug] = {name: teamName, league: league};

  res.redirect('/');
});

//
// DELETE
//
app.get('/team/delete/:slug', (req, res) => {
  const slug = req.params.slug;
  delete teams[slug];
  res.redirect('/');
});

//
// LISTEN EVENT HANDLER
//

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});