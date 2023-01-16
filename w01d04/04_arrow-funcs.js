// added in ES6 (stolen from coffeescript)
// 1. no function keyword!!!
// 2. if only one argument, no parens needed
// 3. if only one line of code, no curly braces needed
// 4. if no curly braces, the line of code is implicitly returned
// 5. arrow funcs do not create `this`

// function() {}
// () => {}

const sayHello1 = function(name) {
  return `hello there ${name}`;
};

const sayHello2 = name => `hello there ${name}`;

const returnVal = sayHello2('alice');

console.log('returnVal from sayHello2', returnVal);

const sayGoodbye = function() {
  console.log(this);
  console.log(`goodbye from ${this.name}`);
};

sayGoodbye();

const myObj = {
  name: 'alice',
  sayGoodbye: sayGoodbye
};

myObj.sayGoodbye();
