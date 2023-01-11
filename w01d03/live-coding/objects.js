// // Boolean
// let awesome = true;

// if (awesome){ // is the value of the awesome variable useful?
//   // do awesome things
// } else {
//   // fdasfdsafdsa
// }

// // Null
// const iAmNull = null;
// console.log('typeof iAmNull', typeof iAmNull);

// // Undefined
// function doStuff(param){
//   console.log('param', param);
//   param = param * 2;
// }

// const returnValue = doStuff(4);
// console.log('returnValue', returnValue);
// console.log('typeof returnValue', typeof returnValue);

// // Number
// let myNumber = 5.1;
// console.log('typeof myNumber', typeof myNumber);

// // Bigint
// const bigint = 9007199254740991n;

// // String
// const str = 'This is a string';
// const str2 = "This is a string";
// const str3 = `This is another string`;

// // Symbol
// const sym = Symbol('symbol');
// console.log('typeof sym', typeof sym);


// // Primitive types are immutable

// let myOtherString = 'hello world';
// console.log('myOtherString', myOtherString);
// let newString = myOtherString.replace('hello', 'goodbye');
// console.log('myOtherString', myOtherString);
// console.log('newString', newString);

// // Objects
// const myObject = {}; // this is an (empty) object
// const myObject2 = { // this is an object
//   league: 'NFL',
//   teamName: 'Patriots' 
// };

// myObject2.numberOfPlayers = 20;
// console.log('myObject2.numberOfPlayers', myObject2.numberOfPlayers);


// // terrible vote talling app code
// const voterOneName = 'Nally';
// const voterOneAge = 52;
// const voterOneDidVote = true;

// const voterTwoName = 'Monkey Fuzz';
// const voterTwoAge = 42;
// const voter2DidVote = false;

// const voterThreeName = 'Monkey Fur';
// const voterThreeAge = 2;
// const voterThreeDidVote = true;

// console.log('Names:', voterOneName, voterTwoName, voterThreeName);

// // Arrays
// const myArray = []; // this is an (empty) Array

// const nameOfProperty = 'league';

// console.log('myObject2.league', myObject2.league);
// console.log("myObject2['league']", myObject2['league']);
// console.log("myObject2[nameOfProperty]", myObject2[nameOfProperty]);

// primitives are passed into functions BY VALUE

// function doSomeThings(num){

//   num = num + 3;

//   for (let ii = 0; ii < num; ii++){
//     console.log('do some things!');
//   }
  
// }

// let numberOfTimes = 5;
// doSomeThings(numberOfTimes);
// console.log('numberOfTimes', numberOfTimes);


// // OBJECTS are passed into functions BY REFERENCE

// function doSomeOtherThings(numObj){

//   numObj.num = numObj.num + 3;

//   for (let ii = 0; ii < numObj.num; ii++){
//     console.log('do some other things!');
//   }
  
// }

// let numberOfOtherTimesObject = {
//   num: 1
// };
// doSomeOtherThings(numberOfOtherTimesObject);
// console.log('numberOfOtherTimesObject', numberOfOtherTimesObject);

let x = 5;
const nameOne = 'monkeyfuzz';
const action = function (){
  console.log('do SOMETHING!');
};


action();

const myObject = {
  age: x,
  myName: nameOne,
  favoriteTrick: function doThings(){
    console.log('do SOMETHING!:', this.age);
    console.log('do SOMETHING ELSE!:', this.myName);
  }
};

console.log('myObject.age', myObject.age);
myObject.favoriteTrick();
