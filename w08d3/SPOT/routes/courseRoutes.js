const express = require("express");
const router = express.Router();
module.exports = (dbFns) => {

  router.get("/delete/:id", (req, res) => {
    const id = req.params.id;
    dbFns.deleteCourse(id)
    .then(() => {
      res.json(id);
    })
    .catch((error) => {
      console.log('error',error);
    });

  });

  router.get("/", (req, res) => {
    const id = req.params.id;
    dbFns.getAllCourses()
    .then((response) => {
      res.render('courses',{rows: response.rows, profile: req.oidc.user})
    });
  });

  return router;
};
