require('dotenv').config(); // nodejs dotenv module
const authMiddleware = require('./auth');

// HTTP vs HTTPS
const useHTTPS = false;

//
// SPOT Back-end
//
const cookieSession = require('cookie-session');
const express = require("express");
const morgan = require("morgan");
const crypto = require("crypto"); // used to generate random strings
const bcrypt = require("bcrypt");
var bodyParser = require("body-parser");
const cors = require('cors');

const https = require('https');
const fs = require('fs');
const util = require('util');

// define the logger
const log4js = require("log4js");
const logger = log4js.getLogger();
logger.level = "fatal"; // default level is OFF - which means no logs at all.
// ALL < TRACE < DEBUG < INFO < WARN < ERROR < FATAL < MARK

// local require for DB API
const dbFns = require("./db/queries");

// someone set us up the parts
const app = express();
app.set("view engine", "ejs");
app.disable('view cache'); // my register page was caching the header email/login form
// app.disable('etag'); // this was suggested here and is NOT working https://stackoverflow.com/questions/18811286/nodejs-express-cache-and-304-status-code

// this object keeps a list of all the currently logged in users
// a user is added to the list whenever we recieve a request from any user
// and they're not in this list
const loggedInUsers = {};

//
// Middleware
//
app.use(express.static("public"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(morgan("dev"));
app.use(cookieSession({
  name: 'session',
  keys: ['qhd7h3f09js83nnc9', 'aovjhaw48hofgraoh8']
}));
app.use(cors());
app.use(authMiddleware);

// auth router attaches /login, /logout, and /callback routes to the baseURL
// app.use(auth(config));

//
// Routing
//

const curriculaRoutes = require("./routes/curriculaRoutes"); // curricula
app.use("/curricula", curriculaRoutes(dbFns));

const courseRoutes = require("./routes/courseRoutes"); // courses
app.use("/courses", courseRoutes(dbFns));

const courseOutcomeRoutes = require("./routes/courseOutcomeRoutes"); // course_outcomes
app.use("/course_outcomes", courseOutcomeRoutes(dbFns));

const unitOutcomeRoutes = require("./routes/unitOutcomeRoutes"); // unit_outcomes
app.use("/unit_outcomes", unitOutcomeRoutes(dbFns));

const objectiveRoutes = require("./routes/objectiveRoutes"); // objectives
app.use("/objectives", objectiveRoutes(dbFns));

const dayRoutes = require("./routes/dayRoutes"); // days
app.use("/days", dayRoutes(dbFns));

//
// Auth0 Open Routes
//
// app.get('/callback', (req,res) => {
//   console.log('GET /callback');
//   res.render('home');
// });
// app.post('/callback', (req,res) => {
//   console.log('POST /callback');
//   res.render('home');
// });
// app.get('/after-auth0-login', (req,res) => {
//   res.render('home');
// });
// app.get('/after-auth0-logout', (req,res) => {
//   res.render('home');
// });

//
// LOGOUT
//
app.get('/logout', function (req, res) {
  res.status(401).send('Logged out: <a href="/">Home</a>');
});

//
// Protected Routes
//
app.get('/profile', (req, res) => {
  const templateVars = {
    profile: req.session.credentials
  };
  res.render('profile',templateVars);
});

//app.get("/loggedInUsers", (req, res) => {
//  if (true){
//    logger.debug('loggedInUsers:',loggedInUsers);
//    res.json(loggedInUsers);
//  } else {
//    res.write('permission denied');
//  }
//});


//
// BREAD ROUTES for understanding
//
app.get("/understanding", (req, res) => {
  const userEmail = req.session.credentials.email;
  if(userEmail){
    // DO PROTECTED STUFF IN HERE
    logger.debug('understanding:',understandingLOL);
    res.json(understandingLOL);
  } else { // userEmail is falsey
    res.write('userEmail not defined');
    res.end();
  }
  return;
});

//
// Here is how an individual submits their feedback
//
app.get("/understanding/:objective_id/:level", (req,res)=>{
  const objective_id = req.params.objective_id;
  const email = req.oidc.user.email;

  dbFns.getUserByEmail(email, (rows)=>{
    if (rows.length && typeof rows[0].email !== 'undefined'){
      logger.debug("rows[0]",rows[0]);
      // we have a valid user
      const user_id = rows[0].id;
      const level = req.params.level;
    
      if ( !( 'undefined' !== typeof understandingLOL[objective_id] ) ){
        understandingLOL[objective_id] = {};
      }
    
      understandingLOL[objective_id][user_id] = level;
      const newUnderstanding = {
        user_id: user_id,
        objective_id: objective_id,
        understanding_id: level
      };
      dbFns.insertUnderstanding(newUnderstanding);
    
      logger.debug('understanding after:',understandingLOL);
      res.json(understandingLOL);
      return;
    } else {
      logger.debug('user not logged in. no understanding permitted.');
    }
  });
});

// req.isAuthenticated is provided from the auth router
app.get('/', (req, res) => {
//  res.send(req.oidc.isAuthenticated() ? 'Logged in' : 'Logged out');
//  console.log('auth0 profile:', req.oidc.user);
  const templateVars = {
    profile: req.session.credentials
  };
  res.render('home',templateVars);
});

// CYCLE
app.get("/cycle", (req, res) => {
  const userEmail = req.session.credentials.email;
  if(userEmail){
    dbFns.getAllObjectives((rows) => {
      const templateVars = { objectives: rows, email: userEmail };
      res.render("cycle", templateVars);
    });
    return;
  }
});

// Curriculum Top Level
app.get("/toplevel/:id", (req, res) => {
  const userEmail = req.session.credentials.email;
  const curriculum = req.params.id;
  if(userEmail){ // if logged in
    dbFns.getTopLevel(curriculum)
    .then((unit_outcomes) => {
//      console.log('unit_outcomes',util.inspect(unit_outcomes, {showHidden: false, depth: null, colors: true}));
      const courses = {};
      for (let unit_outcome of unit_outcomes) {
        if (!courses[unit_outcome.course_id]){
          courses[unit_outcome.course_id] = {description: unit_outcome.course_description};
        }
        if (!courses[unit_outcome.course_id]['course_outcomes']){
          courses[unit_outcome.course_id]['course_outcomes'] = {};
        }
        if (!courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]){
          courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id] = {};
        }
        if (!courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['description']){
          courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['description'] = unit_outcome.course_outcome_description;
        }
        if (!courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['unit_outcomes']){
          courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['unit_outcomes'] = {};
        }
        if (!courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['unit_outcomes'][unit_outcome.unit_outcome_id]){
          courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['unit_outcomes'][unit_outcome.unit_outcome_id] = {};
        }
        if (!courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['unit_outcomes'][unit_outcome.unit_outcome_id].description){
          courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['unit_outcomes'][unit_outcome.unit_outcome_id].description = unit_outcome.unit_outcome_description;
        }
        // console.log(`adding course_id ${unit_outcome.course_id}, course_outcome_description ${unit_outcome.course_outcome_description} and unit_outcome_id ${unit_outcome.unit_outcome_id}`);
        // courses[unit_outcome.course_id]['course_outcomes'][unit_outcome.course_outcome_id]['unit_outcomes'] = unit_outcome.unit_outcome_description;
      }
      // console.log('courses',util.inspect(courses, {showHidden: false, depth: null, colors: true}));
      const templateVars = { courses: courses, email: userEmail };
      res.render("toplevel", templateVars);
    })
    .catch((err) => {console.log('getTopLevel error:',err)});
    return;
  }
  // if not logged in
});

//
// "BREAD" ROUTES for Tags
//
app.get("/tags", (req,res) => {
  if (dbFns.isAdmin(req)) {
    dbFns.getAllTags((rows) => {
      const templateVars = { tags: rows, email: req.oidc.user.email };
      res.render("tags", templateVars);
    });
  } else {
    res.write('permission denied');
  }
});

//
// REORDER
//
app.post("/neworder", (req, res) => {
  if (req.session.user.admin){
    logger.debug("/neworder req.body:", req.body);
    const nameOfArray = "objective[]";
    for (key in req.body[nameOfArray]) {
      logger.debug("key::value", key, "::", req.body[nameOfArray][key]);
      let newOrder = { id: req.body[nameOfArray][key], sort: key };
      dbFns.setObjectiveSortOrder(newOrder);
    }
    res.send("reordered");
    res.end();
  } else {
    res.write('permission denied');
  }
});

// Server Listen Event Handler
//

const port = process.env.PORT || 7865;

if (useHTTPS) {
  const httpsOptions = {
    key: fs.readFileSync('./key.pem'),
    cert: fs.readFileSync('./cert.pem')
  }
  https.createServer(httpsOptions, app).listen(port, '0.0.0.0', () => {
    console.log('server listening for HTTPS on ' + port)
  });
} else {
  app.listen(port, ()=>{
    console.log(`SPOT server listening for HTTP on port=${port}`);
  });
}
