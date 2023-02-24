// import {useState} from 'react';
import useInput from "../hooks/useInput";

const Form = () => {
  // const [username, setUsername] = useState('');
  // const [password, setPassword] = useState('');

  const usernameInput = useInput('');
  const passwordInput = useInput('');

  const submitHandler = (event) => {
    event.preventDefault();
    alert(`you are trying to sign in as ${usernameInput.value} with password ${passwordInput.value}`);
  };

  return (
    <div>
      <h2>Login Below!</h2>
      <form onSubmit={submitHandler}>
        <label>Username</label>
        <input 
          value={usernameInput.value}
          onChange={usernameInput.onChange}
        />
        <br/>
        <label>Password</label>
        <input 
          // value={password}
          // onChange={(event) => setPassword(event.target.value)}

          { ...passwordInput }
        //  onBlur={passwordInput.onBlur}
        />
        <br/>
        <button type="submit">Login!</button>
      </form>
    </div>
  );
};

export default Form;
