const log4js = require("log4js");
// define the logger
const logger = log4js.getLogger();
logger.level = "all"; // default level is OFF - which means no logs at all.
// ALL < TRACE < DEBUG < INFO < WARN < ERROR < FATAL < MARK

const client = require("./connection");

//
// Users
//

const isAdmin = (req) => {
  return (req.session.credentials.admin);
}

const getUserByEmail = (email,cb) => {
  client
  .query('SELECT * FROM public.users WHERE email = $1;',[email])
  .then((response) => {
    cb(response.rows);
  })
  .catch((err)=>{
    logger.debug("getUserByEmail query error:", err);
  });
};

const insertUser = (newObj) => {
  return client
  .query(
    "INSERT INTO public.users (email,password) VALUES ($1,$2) RETURNING id;",
    [newObj.email,newObj.hashedPassword]
  )
  .then((response) => {
    logger.debug("response.rows[0]",response.rows[0]);
    return true; // TODO can we return the new ID for this new row?
  })
  .catch((err) => {
    logger.debug("insertUser query error:", err);
  });
}

//
// Understanding
//

const getAllUnderstandings = (cb) => {
  return client
  .query(
    "SELECT user_id, objective_id, level FROM public.understandings;"
  )
  .then((response) => {
    logger.debug('getAllUnderstandings response.rows',response.rows);
    cb(response.rows);
  })
  .catch((err) => {
    logger.debug("insertObjective query error:", err);
  });
};

const insertUnderstanding = (newObj) => {
  return client
  .query(
    "INSERT INTO public.understandings (user_id, objective_id, level) VALUES ($1,$2,$3) RETURNING *;",
    [newObj.user_id, newObj.objective_id, newObj.understanding_id]
  )
  .then((response) => {
    logger.debug('inserting understanding into public.the understandings table',response.rows);
    return true; // TODO can we return the new ID for this new row?
  })
  .catch((err) => {
    logger.debug("insertObjective query error:", err);
  });
};

//
// Days
//
const getAllDays = (cb) => {
  client
    .query(
      `SELECT days.title, days.id, day_mnemonic, count(question)
      FROM public.days 
      LEFT JOIN objectives ON objectives.day_id = days.id
      GROUP BY days.id, days.day_mnemonic
      ORDER BY days.day_mnemonic;`
    )
    .then((response) => {
      cb(response.rows);
    })
    .catch((err) => {
      logger.debug("getAllDays query error:", err);
    });
};

const getDay = (day_id) => {
  return client
    .query(
      `SELECT objectives.id,type,question,answer,sort,day_id, day_mnemonic 
      FROM public.objectives 
      LEFT JOIN days ON objectives.day_id = days.id 
      WHERE day_id = $1 
      ORDER BY sort;`,
      [day_id]
    )
    .catch((err) => {
      logger.debug("getDay query error:", err);
    });
};

const getDayDetails = (day_id, cb) => {
  return client
    .query(
      `SELECT id, day_mnemonic, title 
      FROM public.days 
      WHERE id = $1`,
      [day_id]
    )
    .then((response) => {
      return cb(response.rows);
    })
    .catch((err) => {
      logger.debug("getDayDetails query error:", err);
    });
};

const updateDay = (dayUpdate) => {
  const query = "UPDATE days SET day_mnemonic = $2, title = $3 WHERE id = $1;";
  const valuesArray = [dayUpdate.id,dayUpdate.day_mnemonic,dayUpdate.title];
  logger.debug('query debug:',query + '::' + valuesArray);
  return client
  .query(query,valuesArray)
  .then((response) => {
    logger.debug("updateDay response.rows",response.rows);
    return true; // TODO can we return the new ID for this new row?
  })
  .catch((err) => {
    logger.debug("insertObjective query error:", err);
  });
}

//
// Tags
//
const getAllTags = (cb) => {
  client
    .query(
      `SELECT tags.name, tags.id
      FROM public.tags 
      ORDER BY tags.name;`
    )
    .then((response) => {
      cb(response.rows);
    })
    .catch((err) => {
      logger.debug("getAllTags query error:", err);
    });
};

//
// Objectives
//

const getTopLevel = (curriculum) => {

  return client
    .query(
      `SELECT DISTINCT unit_outcomes.id AS unit_outcome_id,
        unit_outcomes.description AS unit_outcome_description,
        course_outcomes.id AS course_outcome_id,
        course_outcomes.description AS course_outcome_description,
        courses.id AS course_id,
        courses.description AS course_description
      FROM public.unit_outcomes 
      RIGHT JOIN course_outcomes ON unit_outcomes.course_outcome_id = course_outcomes.id 
      RIGHT JOIN courses ON course_outcomes.course_id = courses.id 
      RIGHT JOIN curricula ON courses.curriculum_id = $1
      ORDER BY unit_outcomes.id
      ;`
      ,
      [curriculum]
    )
    .then((result) => {
      return result.rows;
    });
};

const getWorkOutcomesByCourseID = (course_id) => {
  return client.query(
    `SELECT id,
      description
    FROM public.outcomes 
    WHERE course_id = ${course_id}
    ORDER BY id;`
  );
};

const getAllWorkOutcomes = () => {
  return client.query(
    `SELECT id,
      description
    FROM public.outcomes 
    ORDER BY id;`
  )
  .catch((error) => {
    logger.debug("getAllWorkOutcomes query error:", error);
  });
};

const getAllObjectives = (cb) => {
  client
    .query(
      `SELECT objectives.id,
        type,
        question,
        answer,
        sort,
        day_id, 
        total_time,
        parent_id,
        days.day_description
      FROM public.objectives 
      INNER JOIN days ON days.id = day_id
      ORDER BY day_id,sort;`
    )
    .then((response) => {
      cb(response.rows);
    })
    .catch((err) => {
      logger.debug("getAllObjectives query error:", err);
    });
};

const getAllCurricula = () => {
  return client
    .query(
      `SELECT id, description
      FROM public.curricula 
      ORDER BY id;`
    )
    .catch((err) => {
      logger.debug("getAllCurricula query error:", err);
    });
};

const getAllCourses = () => {
  return client
    .query(
      `SELECT id, description
      FROM public.courses 
      ORDER BY id;`
    )
    .catch((err) => {
      logger.debug("getAllCourses query error:", err);
    });
};

const getObjectiveById = (id) => {
  return client
    .query(
      `SELECT id,
        type,
        question,
        answer,
        svg_diagram,
        sort,
        day_id,
        total_time,
        parent_id 
      FROM public.objectives 
      WHERE id = $1;`,
      [id]
    )
    .then((response) => {
      return response.rows[0];
    })
    .catch((err) => {
      logger.debug("getObjectiveById query error:", err);
    });
};

const getNextObjectiveInDay = (objective_id) => {
  return client.query(
    'SELECT day_id FROM public.objectives WHERE id = $1',[objective_id]
  ).then((result) => {
    console.log('result',result);
    return result.rows[0].day_id;
  }).catch((error) => {
    console.log('error finding day_id for objective_id', error);
  });
};

const getObjectivesByTagId = (tag_id) => {
  return client
    .query(
      `SELECT objectives.id,
        tags_objectives.tag_id AS t_o_tag_id,
        tags.id AS tag_id,
        type,
        question,
        answer,
        sort,
        day_id,
        total_time,
        parent_id 
      FROM public.objectives 
      INNER JOIN tags_objectives ON tags_objectives.objective_id = objectives.id
      INNER JOIN tags ON tags.id = tags_objectives.tag_id
      WHERE tags_objectives.tag_id = $1;`,
      [tag_id]
    )
    .then((response) => {
      console.log('response',response);
      return response.rows;
    })
    .catch((err) => {
      logger.debug("getObjectivesByTagId query error:", err);
    });
};

const insertObjective = (newObj) => {
  if (newObj.parent_id === '') {
    return client
    .query(
      `INSERT INTO public.objectives (type,question,answer,sort,day_id,total_time) 
      VALUES ($1,$2,$3,$4,$5,$6);`,
      [newObj.type,newObj.question,newObj.answer,newObj.sort,newObj.day_id,newObj.total_time]
    )
    .then((response) => {
      return true; // TODO can we return the new ID for this new row?
    })
    .catch((err) => {
      logger.debug("insertObjective query error (parent === ''):", err);
    });
  }

  return client
  .query(
    `INSERT INTO public.objectives (type,question,answer,sort,day_id,total_time,parent_id) 
    VALUES ($1,$2,$3,$4,$5,$6,$7);`,
    [newObj.type,newObj.question,newObj.answer,newObj.sort,newObj.day_id,newObj.total_time,newObj.parent_id]
  )
  .then((response) => {
    return true; // TODO can we return the new ID for this new row?
  })
  .catch((err) => {
    logger.debug("insertObjective query error:", err);
  });

}

const updateObjective = (objUpdate) => {
  return client
  .query(
    "UPDATE objectives SET type = $1, question = $2, answer = $3, svg_diagram = $8, sort = $4, day_id = $5, total_time = $7 WHERE id = $6;",
    [objUpdate.type,objUpdate.question,objUpdate.answer,objUpdate.sort,objUpdate.day_id,objUpdate.id,objUpdate.total_time, objUpdate.svg_diagram]
  )
  .then((response) => {
    return true; // TODO can we return the new ID for this new row?
  })
  .catch((err) => {
    logger.debug("insertObjective query error:", err);
  });
}

// let newOrder = {id: req.body[nameOfArray][key], sort: key};
// dbFns.setObjectiveSortOrder(newOrder);

const setObjectiveSortOrder = (objUpdate) => {
  return client
  .query(
    "UPDATE objectives SET sort = $1 WHERE id = $2;",
    [objUpdate.sort,objUpdate.id]
  )
  .then((response) => {
    return true; // 
  })
  .catch((err) => {
    logger.debug("setObjectiveSortOrder query error:", err);
  });
}

const deleteObjective = (id) => {
  return client
    .query(
      "DELETE FROM public.objectives WHERE id = $1;",
      [id]
    )
    .then(() => {
      return;
    })
    .catch((err) => {
      logger.debug("deleteObjective query error:", err);
    });
};

//
// Curricula
//

const deleteCurriculum = (id) => {
  return client
    .query("DELETE FROM public.curricula WHERE id = $1;",[id])
    .then((response) => {
      return response.rows;
    });
};

// Course Outcomes
const addNewCourseOutcome = (course_id) => {
  const query = "INSERT INTO public.course_outcomes (course_id,description) VALUES ($1,$2);";
  const values = [course_id,'big d goes here'];
  console.log('query',query);
  console.log('values',values);
  return client
    .query(query,values)
    .then((response) => {
      return response.rows;
    });
};

const updateCourseOutcome = (course_id, newValue) => {
  const query = "UPDATE course_outcomes SET description = $1 WHERE id = $2;";
  const values = [newValue, course_id];
  console.log('query',query);
  console.log('values',values);
  return client
    .query(query,values)
    .then((response) => {
      return response.rows;
    });
};

const deleteCourseOutcome = (id) => {
  return client
    .query("DELETE FROM public.course_outcomes WHERE id = $1;",[id])
    .then((response) => {
      return response.rows;
    });
};

// Unit Outcomes
const addNewUnitOutcome = (course_outcome_id) => {
  const query = "INSERT INTO public.unit_outcomes (course_outcome_id,description) VALUES ($1,$2);";
  const values = [course_outcome_id,'monkey fuzz goes here'];
  console.log('query',query);
  console.log('values',values);
  return client
    .query(query,values)
    .then((response) => {
      return response.rows;
    });
};

const updateUnitOutcome = (course_outcome_id, newValue) => {
  const query = "UPDATE unit_outcomes SET description = $1 WHERE id = $2;";
  const values = [newValue, course_outcome_id];
  console.log('query',query);
  console.log('values',values);
  return client
    .query(query,values)
    .then((response) => {
      return response.rows;
    });
};

const deleteUnitOutcome = (id) => {
  return client
    .query("DELETE FROM public.unit_outcomes WHERE id = $1;",[id])
    .then((response) => {
      return response.rows;
    });
};

module.exports = {
  isAdmin,
  getUserByEmail,
  insertUser,
  getAllTags,
  getAllObjectives,
  getTopLevel,
  getWorkOutcomesByCourseID,
  getAllWorkOutcomes,
  getObjectiveById,
  getNextObjectiveInDay,
  getObjectivesByTagId,
  insertObjective,
  updateObjective,
  setObjectiveSortOrder,
  deleteObjective,
  getAllUnderstandings,
  insertUnderstanding,
  getAllDays,
  getDay,
  getDayDetails,
  updateDay,
  deleteCurriculum,
  getAllCurricula,
  getAllCourses,
  addNewCourseOutcome,
  updateCourseOutcome,
  deleteCourseOutcome,
  addNewUnitOutcome,
  updateUnitOutcome,
  deleteUnitOutcome
};
