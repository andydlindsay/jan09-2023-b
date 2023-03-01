const express = require("express");
const router = express.Router();
module.exports = (dbFns) => {

  router.get("/delete/:id", (req, res) => {
    const id = req.params.id;
    dbFns.deleteCourseOutcome(id)
    .then(() => {
      res.json(id);
    })
    .catch((error) => {
      console.log('error',error);
    });
  });

  router.get("/", (req, res) => {
    const id = req.params.id;
    dbFns.getAllCourseOutcomes((rows) => {
      res.render('courseOutcomes',{rows: rows})
    });
  });

  router.get("/new/:course_id", (req, res) => {
    const course_id = req.params.course_id;
    dbFns.addNewCourseOutcome(course_id)
    .then((rows)=>{
      console.log('rows',rows);
      res.json(rows);
    })
    .catch((error) => {
      console.log('error',error);
    });
  });

  router.post("/update/:course_outcome_id", (req, res) => {
    const course_outcome_id = req.params.course_outcome_id;
    console.log('req.body',req.body);
    const newValue = req.body.newvalue;
    dbFns.updateCourseOutcome(course_outcome_id, newValue)
    .then((rows)=>{
      console.log('rows',rows);
      res.json(rows);
    })
    .catch((error) => {
      console.log('updating course outcome error',error);
    });
  });

  return router;
};
