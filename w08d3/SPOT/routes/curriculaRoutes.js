const express = require("express");
const router = express.Router();
module.exports = (dbFns) => {

  router.get("/delete/:id", (req, res) => {
    const id = req.params.id;
    dbFns.deleteCurriculum(id)
    .then(() => {
      res.json(id);
    })
    .catch((error) => {
      console.log('error',error);
    });

  });

  router.get("/", (req, res) => {
    const id = req.params.id;
    dbFns.getAllCurricula()
    .then((response) => {
      const templateVars = {
        profile: req.session.credentials,
        rows: response.rows
      };
      res.render('curricula',templateVars)
    });

  });

  return router;
};
