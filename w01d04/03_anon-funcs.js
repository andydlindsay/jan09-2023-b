const username = 'Alice';
console.log(username);

console.log('Alice');

const runMyFunction = function(anotherFunc) {
  anotherFunc('alice');
};

const sayHello = function(name) {
  console.log(`hello there ${name}`);
};

runMyFunction(sayHello);

const funcname = function(name) {
  console.log(`hello there ${name}`);
};

runMyFunction(function(name) {
  console.log(`hello there ${name}`);
});



