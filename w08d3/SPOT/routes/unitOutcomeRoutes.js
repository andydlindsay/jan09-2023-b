const express = require("express");
const router = express.Router();
module.exports = (dbFns) => {

  router.get("/delete/:id", (req, res) => {
    const id = req.params.id;
    dbFns.deleteUnitOutcome(id)
    .then(() => {
      res.json(id);
    })
    .catch((error) => {
      console.log('error',error);
    });
  });

  router.get("/", (req, res) => {
    const id = req.params.id;
    dbFns.getAllUnitOutcomes((rows) => {
      res.render('unitOutcomes',{rows: rows})
    });
  });

  router.get("/new/:unit_outcome_id", (req, res) => {
    const unit_id = req.params.unit_outcome_id;
    dbFns.addNewUnitOutcome(unit_id)
    .then((rows)=>{
      console.log('rows',rows);
      res.json(rows);
    })
    .catch((error) => {
      console.log('adding unit outcome error',error);
    });
  });

  router.post("/update/:unit_outcome_id", (req, res) => {
    const unit_id = req.params.unit_outcome_id;
    console.log('req.body',req.body);
    const newValue = req.body.newvalue;
    dbFns.updateUnitOutcome(unit_id, newValue)
    .then((rows)=>{
      console.log('rows',rows);
      res.json(rows);
    })
    .catch((error) => {
      console.log('updating unit outcome error',error);
    });
  });

  return router;
};
