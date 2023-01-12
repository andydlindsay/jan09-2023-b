const dogs = ['Thor', 'Goose', 'Archie', 'Binx', 'Ringo', 'Duck', 'Moose', 'Sypha', 'Yennefer'];

const doOnEveryIteration = (dog) => {
  return `Who's a good dog? ${dog} is!`;
};

const ourMap = (arr, callback) => {
  // create an output array
  const output = [];

  // loop through the provided array
  for (const element of arr) {
    // call the callback for each element AND capture the return value
    const returnVal = callback(element);

    // add the return value to the output array
    output.push(returnVal);
  }

  // return the output array
  return output;
};

console.log(dogs);
const mappedDogs = dogs.map(doOnEveryIteration);
console.log(mappedDogs);

console.log();
const ourMappedDogs = ourMap(dogs, doOnEveryIteration);
console.log(ourMappedDogs);

// console.log(dogs === mappedDogs);
