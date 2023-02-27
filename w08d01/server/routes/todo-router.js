const express = require('express');
const router = express.Router();

// database
const todos = {
  abc: {
    id: 'abc',
    task: 'clean the dishes',
    complete: false 
  },
  def: {
    id: 'def',
    task: 'walk the dog',
    complete: true 
  },
};

// GET /api/todos/
router.get('/', (req, res) => {
  const arr = Object.values(todos);
  res.json(arr);
});

// GET /api/todos/:todoId
router.get('/:todoId', (req, res) => {
  const todoId = req.params.todoId;
  const todo = todos[todoId];
  res.json(todo);
});

// POST /api/todos/
router.post('/', (req, res) => {
  const task = req.body.task;
  const complete = false;
  const id = Math.random().toString(36).substring(2, 5);

  const newTodo = {
    id,
    task,
    complete
  };

  todos[id] = newTodo;
  console.log(todos);

  res.status(201).send(newTodo);
});

// POST /api/todos/:todoId
router.patch('/:todoId', (req, res) => {
  const todoId = req.params.todoId;
  const newTask = req.body.newTask;

  todos[todoId].task = newTask;

  res.status(200).send({ status: 'complete' });
});

// DELETE /api/todos/:todoId
router.delete('/:todoId', (req, res) => {
  const todoId = req.params.todoId;
  delete todos[todoId];
  res.status(200).send({ deleted: true });
});

module.exports = router;
