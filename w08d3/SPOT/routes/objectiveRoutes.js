const express = require("express");
const router = express.Router();
const marked = require('marked');

// define the logger
const log4js = require("log4js");
const logger = log4js.getLogger();
logger.level = "fatal"; // default level is OFF - which means no logs at all.
// ALL < TRACE < DEBUG < INFO < WARN < ERROR < FATAL < MARK

module.exports = (dbFns) => {

  //
  // "BREAD" Routes for Objectives
  //

  // Browse all objectives
  router.get("/browse", (req, res) => {
    dbFns.getAllObjectives((rows) => {
      const userEmail = req.session.credentials.email;
      const templateVars = { objectives: rows, email: userEmail };
      res.render("browse", templateVars);
    });
  });

  router.get("/json", (req, res) => {
    dbFns.getAllObjectives((rows) => {
      res.json(rows);
    });
  });

  // List of Objectives By Tag
  router.get("/by-tag/:tag_id", (req, res) => {
    const tag_id = req.params.tag_id;
    dbFns.getObjectivesByTagId(tag_id)
      .then((result) => {
        logger.debug("result:", { objectives: result, email: req.oidc.user.email });
        res.render("objectives_by_tag", { objectives: result, email: req.oidc.user.email });
      })
      .catch((err) => {
        logger.debug("getObjectiveById err:", err);
        res.status(500).send('getObjectiveById err');
      });
  });

  // Read an Objective
  router.get("/:id", (req, res) => {
    const id = req.params.id;
    let day_id = 0;
    const templateVars = {};
    console.log('objective id', id);
    dbFns.getNextObjectiveInDay(id)
      .then((dayId) => {
        day_id = dayId;
        console.log(`objective_id:${id} is on day_id ${dayId}`);
        return dbFns.getDay(dayId);
      })
      .then((response) => {
        console.log('getDay response:', response);

        templateVars.objectiveList = [];
        response.rows.forEach((obj) => {
          if (obj.id == id) { // these types do not match
            templateVars.objectiveList.push(`<span class="current">${obj.id}</span>`);
          } else {
            templateVars.objectiveList.push(`<a href="/objectives/${obj.id}">${obj.id}</a>`);
          }
        });
        console.log(`templateVars: ${JSON.stringify(templateVars)}`);
        return dbFns.getObjectiveById(id);
      })
      .then((result) => {
        console.log("result:", result);
        try {
          templateVars.question = marked.parse('# ' + result.question);
          templateVars.answer = marked.parse(result.answer);
        } catch (error) {
          console.log('error parsing markdown', error);
        }
        templateVars.svg_diagram = (result.svg_diagram ? result.svg_diagram : '');
        templateVars.total_time = result.total_time;
        templateVars.id = result.id;
        templateVars.email = '';
        // templateVars.profile = req.oidc.user;
        templateVars.profile = { email: 'monkeyfuzz@example.com' };
        console.log(`templateVars intermediate: ${JSON.stringify(templateVars)}`);
        res.render("objectives", templateVars);
      })
      .catch((err) => {
        logger.debug("getObjectiveById err:", err);
        res.status(500).send('getObjectiveById err');
      });
  });

  // Edit an Objective
  router.get("/edit/:id", (req, res) => {
    if (dbFns.isAdmin(req)) {
      console.log('isAdmin');
      console.log('req.params.id:', req.params.id);
      dbFns.getObjectiveById(req.params.id)
        .then((result) => {
          console.log('result:', result);
          result['email'] = 'monkeyfuzz@example.com';
          res.render("edit", result);
        })
        .catch((err) => {
          logger.debug("getObjectiveById err:", err);
          res.status(500).send('getObjectiveById err');
        });
    } else {
      res.write('permission denied');
      res.end();
    }
  });

  router.post("/edit", (req, res) => {
    if (dbFns.isAdmin(req)) {
      logger.debug("req.body:", req.body);
      const objectiveUpdate = {
        id: req.body.id,
        type: req.body.type,
        question: req.body.question,
        answer: req.body.answer,
        svg_diagram: req.body.svgdiagram,
        sort: req.body.sort,
        day_id: req.body.day_id,
        total_time: req.body.total_time
      };
      logger.debug("objectiveUpdate:", objectiveUpdate);
      dbFns.updateObjective(objectiveUpdate);
      res.redirect("/days");
    } else {
      res.write('permission denied');
    }
  });

  // Add an Objective
  router.get("/new", (req, res) => {
    if (dbFns.isAdmin(req)) {
      const userEmail = req.session.credentials.email;
      res.render("objective-new", { email: userEmail });
      return;
    }

  });

  router.get("/new/:day_id", (req, res) => {
    if (dbFns.isAdmin(req)) {
      const userEmail = req.session.credentials.email;
      res.render("objective-new", { email: userEmail, day_id: req.params.day_id });
      return;
    }

  });

  router.post("/new/:day_id", (req, res) => {
    if (dbFns.isAdmin(req)) {
      const userEmail = req.session.credentials.email;
      if (userEmail) {
        logger.debug("req.body:", req.body);
        const newObjective = {
          type: req.body.type,
          question: req.body.question,
          answer: req.body.answer,
          sort: req.body.sort,
          day_id: req.body.day_id,
          parent_id: req.body.parent_id
        };
        dbFns.insertObjective(newObjective);
        res.redirect(`/days/${req.params.day_id}`);
        return;
      }

    } else {
      res.write('permission denied');
    }
  });

  router.post("/new", (req, res) => {
    if (dbFns.isAdmin(req)) {
      const userEmail = req.session.credentials.email;
      if (userEmail) {
        logger.debug("req.body:", req.body);
        const newObjective = {
          type: req.body.type,
          question: req.body.question,
          answer: req.body.answer,
          sort: req.body.sort,
          day_id: req.body.day_id,
          parent_id: req.body.parent_id
        };
        dbFns.insertObjective(newObjective);
        res.redirect(`/days}`);
        return;
      }

    } else {
      res.write('permission denied');
    }
  });

  // Delete an Objective
  router.get("/delete/:id", (req, res) => {
    if (dbFns.isAdmin(req)) {
      dbFns.deleteObjective(req.params.id);
      res.redirect("/");
    } else {
      res.write('permission denied');
    }
  });

  // Delete and return to Day
  router.get("/delete/:id/:day_id", (req, res) => {
    if (dbFns.isAdmin(req)) {
      dbFns.deleteObjective(req.params.id);
      res.redirect(`/days/${req.params.day_id}`);
    } else {
      res.write('permission denied');
    }
  });

  return router;
};
