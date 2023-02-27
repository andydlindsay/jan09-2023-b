import TodoListItem from "./TodoListItem";

const TodoList = (props) => {
  console.log(props);

  const mappedTodos = props.todos.map((todo) => {
    return <TodoListItem key={todo.id} {...todo} />
  });

  return (
    <div>
      <h2>Todo List</h2>
      { mappedTodos }
    </div>
  );
};

export default TodoList;
