const ourForEach = (arr, callback) => {
  // loop through the provided array
  for (let i = 0; i < arr.length; i++) {
    const element = arr[i];

    // call the provided callback with each element of the array
    callback(element, i);
  }
};

const dogs = ['Thor', 'Goose', 'Archie', 'Binx', 'Ringo', 'Duck', 'Moose', 'Sypha', 'Yennefer'];

const doForEachDog = (dog, index) => {
  console.log(`${dog} wants a treat at index ${index}`);
};

// for (const dog of dogs) {
//   console.log(`${dog} wants to go for a walk`);
// }

dogs.forEach(doForEachDog);
console.log();
ourForEach(dogs, doForEachDog);
