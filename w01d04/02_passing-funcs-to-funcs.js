const runMyFunction = function(anotherFunc) {
  // console.log(anotherFunc.toString()); // sayHello.toString()
  anotherFunc(console.log);
};

const sayHello = function(name) {
  console.log(`hello there ${name}`);
};

const addTwo = function(num) {
  console.log(num + 2);
}

runMyFunction(sayHello);
// runMyFunction(addTwo);
