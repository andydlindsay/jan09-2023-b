const express = require('express');
const router = express.Router();

const client = require('../db/connect');

router.use((req, res, next) => {
  // if (!req.session.userId) {
  //   return res.redirect('/login');
  // }
  console.log('inside the blogpost router');
  next();
});

// GET /blogposts/
router.get('/', (req, res) => {
  client.query('SELECT * FROM blogposts;')
    .then((response) => {
      res.json(response.rows);
    });
});

// GET /blogposts/:id
router.get('/:id', (req, res) => {
  const id = req.params.id;
  client.query('SELECT * FROM blogposts WHERE id = $1;', [id])
    .then((response) => {
      res.json(response.rows[0]);
    });
});

module.exports = router;
