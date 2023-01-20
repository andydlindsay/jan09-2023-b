const functions = require('./promise-generator');

const returnPromise = functions.returnPromise;
const returnRejectedPromise = functions.returnRejectedPromise;

const randomDelay = () => Math.floor(Math.random() * 5000);

const promiseOne = returnPromise('one', 1000);
const promiseTwo = returnRejectedPromise('two', 2000);
const promiseThree = returnPromise('three', 3000);

const promises = [promiseOne,  promiseTwo, promiseThree];

Promise.race(promises)
  .then((data) => {
    console.log(data);
  })
  .catch((err) => {
    console.log('err:',err);
  });
