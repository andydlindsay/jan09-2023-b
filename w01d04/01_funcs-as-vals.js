// functions are first-class - that they can be treated like objects 

// sayHello();

// function sayHello() {}
// const sayHello = function(name) {
//   // return `hello there ${name}`;
//   console.log(`hello there ${name}`);
// };

// sayHello('alice');

// const a = sayHello('carol');
// console.log('a', a);

// const b = sayHello;
// // console.log(sayHello());
// console.log(sayHello.toString());
// console.log();
// console.log(b.toString());

// b('dean'); // sayHello('dean');

const sayHello = function(name) {
  console.log(`hello there ${name}`);
};

const myFuncs = [];
myFuncs.push(sayHello);
myFuncs.push(console.log);

console.log(myFuncs);

const copy = myFuncs[0];
copy('elise');

myFuncs[0]('elise');

// console.log(sayHello);

// sayHello.secretPhrase = '42 is the lucky number';

// console.log(sayHello);

// jQuery();
// jQuery.ajax();
