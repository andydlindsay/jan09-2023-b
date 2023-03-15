"use strict";
// input, output, name
const sayHello = (firstName, age = 42) => {
    return `hello there ${firstName}`;
};
const returnVal1 = sayHello('dean');
const returnVal2 = sayHello('dean', 42);
const returningPromise = (num) => {
    return new Promise((resolve, reject) => {
        // resolve(num);
        reject(new Error('bad stuff happened'));
    });
};
returningPromise(2).then((data) => { });
const higherOrderFunc = (callback) => {
    callback(false);
};
const myCallback = (myBool) => { return 'hello'; };
higherOrderFunc(myCallback);
