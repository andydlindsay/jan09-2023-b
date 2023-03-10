import {useState} from 'react';

const useInput = (initialValue) => {
  const [value, setValue] = useState(initialValue);

  const onChange = (event) => setValue(event.target.value);

  const clear = () => setValue('');

  return {
    value,
    onChange,
    onBlur: clear
  };
};

export default useInput;
