const functions = require('./promise-generator');

const returnPromise = functions.returnPromise;
const returnRejectedPromise = functions.returnRejectedPromise;

const randomDelay = () => Math.floor(Math.random() * 5000);

const delayOne = randomDelay();
console.log('delayOne', delayOne);
const delayTwo = randomDelay();
console.log('delayTwo', delayTwo);
const delayThree = randomDelay();
console.log('delayThree', delayThree);

const promiseOne = returnPromise('one', delayOne);
const promiseTwo = returnPromise('two', delayTwo);
const promiseThree = returnPromise('three', delayThree);

const promises = [promiseOne,  promiseTwo, promiseThree];

Promise.race(promises)
  .then((data) => {
    console.log('success::', data);
  })
  .catch((err) => {
    console.log('err:',err);
  });
