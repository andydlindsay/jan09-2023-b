import './App.css';
import TodoList from './components/TodoList';
import About from './components/About';
import Home from './components/Home';
import {useState, useEffect} from 'react';
import axios from 'axios';

// const originalTodos = [
//   {
//     id: 'hij',
//     task: 'comb the llama',
//     complete: false
//   },
//   {
//     id: 'klm',
//     task: 'fill the bicycle tires with air',
//     complete: true
//   },
// ];

const App = () => {
  const [todos, setTodos] = useState([]);
  const [mode, setMode] = useState('home');

  useEffect(() => {
    axios.get('/api/todos')
      .then((response) => {
        setTodos(response.data);
      });
  }, []);

  return (
    <div className="App">
      <h2>Our Amazing App!!</h2>
      <div>
        <button onClick={() => setMode('home')}>Home</button>
        <button onClick={() => setMode('about')}>About</button>
        <button onClick={() => setMode('todo')}>Todo</button>
      </div>

      { mode === 'home' && <Home /> }
      { mode === 'about' && <About /> }
      { mode === 'todo' && <TodoList todos={todos} /> }
    </div>
  );
};

export default App;
