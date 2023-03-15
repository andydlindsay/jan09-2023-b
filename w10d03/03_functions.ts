// input, output, name

const sayHello = (firstName: string, age: number = 42): string => {
  return `hello there ${firstName}`;
};

const returnVal1 = sayHello('dean');
const returnVal2 = sayHello('dean', 42);

const returningPromise = (num: number): Promise<number> => {
  return new Promise((resolve, reject) => {
    // resolve(num);
    reject(new Error('bad stuff happened'));
  });
};

returningPromise(2).then((data) => {});

const higherOrderFunc = (callback: (a: boolean) => string) => {
  callback(false);
};

const myCallback = (myBool: boolean) => { return 'hello' };
higherOrderFunc(myCallback);
