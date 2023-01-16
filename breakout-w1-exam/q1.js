/* Question 1
 *
 *  Implement the functions defined below
 *
 */

/* ===========================================================================
 * MIN - the lowest value in a list
 *
 * For example:
 *
 *    min([6,2,3,4,9,6,1,0,5])
 *
 * Returns:
 *
 *    0
 */
const min = function(arr) {
  // return Math.min(...arr);

  // set up a place to store the lowest value seen so far
  // let lowestValue = Infinity;
  let lowestValue = arr[0];

  // if (!lowestValue) {}

  // look at each element of the provided array
  for (let i = 0; i < arr.length; i++) {
    const element = arr[i];

    // is this element lower than the lowest seen so far?
    if (element < lowestValue) {
      // replace the lowest seen so far with the current element
      lowestValue = element;
    }
  }

  // return the lowest value seen
  return lowestValue;
};


/* ===========================================================================
 * MAX - the highest value in a list
 *
 * For example:
 *
 *    max([6,2,3,4,9,6,1,0,5])
 *
 * Returns:
 *
 *    9
 */

const max = function(arr) {
  let largest = arr[0];
  for (let i of arr) {
    if (largest < i) {
      largest = i;
    }
  }
  return largest;
  
  
};

// const max = function(arr) {
//   // set aside a place in memory for the highest value seen
//   let highestValue = arr[0];

//   // look at each element of the array
//   for (const index in arr) {
//     const element = arr[index];

//     // is the current element higher than our highest value seen?
//     if (element > highestValue) {
//       // if yes, replace the value for highest value with current element
//       highestValue = element;
//     }
//   }

//   // return highest value seen
//   return highestValue;
// };

/* ===========================================================================
 * RANGE - the difference between the highest and lowest values in a list
 *
 * For example:
 *
 *    range([6,2,3,4,9,6,1,0,5])
 *
 * Returns:
 *
 *    9
 */
const range = function(arr) {
  const lowestValue = min(arr);
  const highestValue = max(arr);
  const answer = highestValue - lowestValue;
  return answer;
};

// Don't change below:

module.exports = { min, max, range };
