import './TodoListItem.scss';

const TodoListItem = (props) => {
  console.log(props);
  return (
    <div className="todo-list-item">
      <h2>Task: {props.task} ({props.id})</h2>
    </div>
  );
};

export default TodoListItem;
