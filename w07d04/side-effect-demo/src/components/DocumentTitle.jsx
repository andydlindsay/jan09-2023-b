import {useEffect, useState} from 'react';

const DocumentTitle = () => {
  const [counter, setCounter] = useState(0);

  const [searchTerm, setSearchTerm] = useState('bob');

  // this will be called on every render
  // it happens BEFORE the return
  // document.title = 'welcome to our site!';
  
  // useEffect callback is called _after_ the return
  useEffect(() => {
    console.log('updating the document title');
    document.title = `count has been clicked ${counter} times`;
  }, [counter]);

  useEffect(() => {
    const intervalRef = setInterval(() => {
      console.log('the interval has fired');
    }, 2000);
    
    const cleanup = () => {
      console.log('clearing the interval');
      clearInterval(intervalRef);
    };

    return cleanup;
  }, [counter]);

  return (
    <div>
      <h2>DocumentTitle Component</h2>
      <div>
        <h2>Count: {counter}</h2>
        <button onClick={() => setCounter(counter + 1)}>Increment</button>
      </div>
      <div>
        <label>Search term:</label>
        <input
          value={searchTerm}
          onChange={(event) => setSearchTerm(event.target.value)}
        />
      </div>
    </div>
  );
};

export default DocumentTitle;
