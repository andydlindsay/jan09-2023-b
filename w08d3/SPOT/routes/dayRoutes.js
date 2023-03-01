const express = require("express");
const router = express.Router();
const marked = require('marked');

// define the logger
const log4js = require("log4js");
const logger = log4js.getLogger();
logger.level = "fatal"; // default level is OFF - which means no logs at all.
// ALL < TRACE < DEBUG < INFO < WARN < ERROR < FATAL < MARK

// this object stores a memory version of the understanding feedback
// this data is VERY emphemeral on purpose, and it also only permits one understanding level per user
const understandingLOL = {};

function understandString(id){
  let totalOne = 0;
  let totalTwo = 0;
  let totalThree = 0;
  if ('undefined' !== typeof understandingLOL[id] ){
    for (const property in understandingLOL[id]) {
//      logger.debug(`${property}: ${understanding[id][property]}`);
      if ("1" === understandingLOL[id][property]){
        totalOne += 1;
      }
      if ("2" === understandingLOL[id][property]){
        totalTwo += 1;
      }
      if ("3" === understandingLOL[id][property]){
        totalThree += 1;
      }
}
//    logger.debug("understanding[id]",understanding[id]);
    return `${totalOne}::${totalTwo}::${totalThree}`;
  } else {
    return "none";
  }
}

module.exports = (dbFns) => {

  // get all of the understanding table // is it better to keep a copy in memory?
  dbFns.getAllUnderstandings((rows)=>{
    rows.forEach((row) => {
      if ( !( 'undefined' !== typeof understandingLOL[row.objective_id] ) ){
        understandingLOL[row.objective_id] = {};
      }
      understandingLOL[row.objective_id][row.user_id] = row.level;  
    });
  });

  //
  // "BREAD" Routes for Days
  //

  // Browse all days
  router.get("/", (req, res) => {
    const userEmail = req.session.credentials.email;
    if(userEmail){
      dbFns.getAllDays((rows) => {
        res.render("days", { days: rows, email: userEmail });
      });
      return;
    }
    
  });

// Admin Read
router.get("/:id", (req, res) => {
  const userEmail = req.session.credentials.email;
  if(userEmail){
    dbFns.getDay(req.params.id)
    .then((response) => {
      response.rows.forEach((obj)=>{ obj.understandString = understandString(obj.id); });
      dbFns.getDayDetails(req.params.id, (row) => {
        //      logger.debug('row[0].day_mnemonic:',row[0].day_mnemonic);
        res.render("day", {
          day_id: req.params.id,
          objectives: response.rows,
          day_mnemonic: row[0].day_mnemonic,
          title: row[0].title,
          email: userEmail
        });
      });
    });
    return;
  } else { // not logged in
    
    return;
  }
});

// Quiz View
// STUDENT READ
router.get("/:id/quiz", (req, res) => {
  const userEmail = req.session.credentials.email;
  if (userEmail){
    dbFns.getDay(req.params.id)
    .then((response) => {
      dbFns.getDayDetails(req.params.id, (row) => {
        //      logger.debug('row[0].day_mnemonic:',row[0].day_mnemonic);
        res.render("quiz", {
          day_id: req.params.id,
          objectives: response.rows,
          day_mnemonic: row[0].day_mnemonic,
          profile: req.oidc.user
        });
      });
    })
    .catch((error) => {
      res.send(`getDay error ${error}`);
    });
  }
});

// Edit
router.get("/edit/:id", (req, res) => {
  const userEmail = req.session.credentials.email;
  if(userEmail){
    dbFns.getDay(req.params.id)
    .then((response) => {
      dbFns.getDayDetails(req.params.id, (row) => {
        logger.debug("row[0].day_mnemonic:", row[0].day_mnemonic);
        res.render("day-edit", {
          day_id: req.params.id,
          objectives: response.rows,
          day_mnemonic: row[0].day_mnemonic,
          title: row[0].title,
          email: userEmail
        });
      });
    });
    return;
  } else { // not logged in
    
    return;
  }
});

router.post("/edit", (req, res) => {
  if (req.session.user.admin){
    logger.debug("req.body:", req.body);
    const dayUpdate = {
      id: req.body.id,
      day_mnemonic: req.body.day_mnemonic,
      title: req.body.title
    };
    dbFns.updateDay(dayUpdate);
    res.redirect("/days-edit/"+dayUpdate.id);
  } else {
    res.write("permission denied");
  }
});

  // // ADD
  // router.get("/new", (req, res) => {
  //   if (req.session.user.admin){
  //     const userEmail = req.session.credentials.email;
  //     res.render("new",{email: userEmail});
  //     return;
  //   }
  //   
  // });

  // router.get("/new/:day_id", (req, res) => {
  //   if (req.session.user.admin){
  //     const userEmail = req.session.credentials.email;
  //     res.render("new", { email: userEmail, day_id: req.params.day_id });
  //     return;
  //   }
  //   
  // });

  // router.post("/new/:day_id", (req, res) => {
  //   if (req.session.user.admin){
  //     const userEmail = req.session.credentials.email;
  //     if(userEmail){
  //       logger.debug("req.body:", req.body);
  //       const newObjective = {
  //         type: req.body.type,
  //         question: req.body.question,
  //         answer: req.body.answer,
  //         sort: req.body.sort,
  //         day_id: req.body.day_id,
  //         parent_id: req.body.parent_id
  //       };
  //       dbFns.insertObjective(newObjective);
  //       res.redirect(`/days/${req.params.day_id}`);
  //       return;
  //     }
  //     
  //   } else {
  //     res.write('permission denied');
  //   }
  // });

  // router.post("/new", (req, res) => {
  //   if (req.session.user.admin){
  //     const userEmail = req.session.credentials.email;
  //     if(userEmail){
  //       logger.debug("req.body:", req.body);
  //       const newObjective = {
  //         type: req.body.type,
  //         question: req.body.question,
  //         answer: req.body.answer,
  //         sort: req.body.sort,
  //         day_id: req.body.day_id,
  //         parent_id: req.body.parent_id
  //       };
  //       dbFns.insertObjective(newObjective);
  //       res.redirect(`/days}`);
  //       return;
  //     }
  //     
  //   } else {
  //     res.write('permission denied');
  //   }
  // });

  // // DELETE
  // router.get("/delete/:id", (req, res) => {
  //   if (req.session.user.admin){
  //     dbFns.deleteObjective(req.params.id);
  //     res.redirect("/");
  //   } else {
  //     res.write('permission denied');
  //   }
  // });

  // // DELETE and return to Day
  // router.get("/delete/:id/:day_id", (req, res) => {
  //   if (req.session.user.admin){
  //     dbFns.deleteObjective(req.params.id);
  //     res.redirect(`/days/${req.params.day_id}`);
  //   } else {
  //     res.write('permission denied');
  //   }
  // });

  return router;
};

