/* Question 2
 *
 *  Implement the functions defined below
 *
 */

// Meant to be used by median. Do not alter.
const round = function(number) {
  return Math.round(number * 100) / 100;
};

/* ===========================================================================
 * MEDIAN - the middle number of a list (when sorted)
 *        - if the list length is even, then the median is the average of the two middle values
 *        - use the provided 'round' function before returning your value
 *
 * For example:
 *
 *    median([6,2,3,4,9,6,1,0,5]);
 *
 * Returns:
 *
 *    4
 */

// 6,2,3,4,9
// 0 1 2 3 4
// length 5, target 2
// 5 / 2 === 2.5 === Math.floor(2.5) === 2

// 6,2,3,4,9,7
// 0 1 2 3 4 5
// length 6, target 3 (2)
// 6 / 2 === 3 - 1 === 2

const median = function(arr) {
  // sort the incoming arr
  arr.sort();

  // calc middleIndex for odd-length arrays
  const middleIndex = Math.floor(arr.length / 2);

  // is the array even-length???
  if (arr.length % 2 === 0) {
    // even-length array
    const valOne = arr[middleIndex];
    const valTwo = arr[middleIndex - 1];

    const average = (valOne + valTwo) / 2;

    const rounded = round(average);
    return rounded;
  }

  // odd-length array
  const value = arr[middleIndex];

  return value; 
};

// Don't change below:
module.exports = { median };
