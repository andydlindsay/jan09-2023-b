// implement a function called sayHello that takes the name of the saluted and 
// returns what would be said.
const sayHello = (toWhom) => {
  let output = '';
  output = `Hello, ${toWhom}!`;
  return output;
};

const sayGoodbye = (toWhom) => {
  let output = '';
  output = `Goodbye, ${toWhom}!`;
  return output;
};

// make the functions exportable
const objectOfFunctions = {
  sayHello: sayHello,
  sayGoodbye: sayGoodbye
};


//
// 
//
// console.log('console', console);

module.exports = objectOfFunctions;
