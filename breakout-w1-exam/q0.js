/* Question 0
 *
 *  Implement the functions defined below
 *
 */

/* ===========================================================================
 * COUNT - the number of items in a list
 *
 * For example:
 *
 *    count([6,2,3,4,9,6,1,0,5]);
 *
 * Returns:
 *
 *    9
 */
const count = function(arr) {
  // const arrLength = arr.length;
  // return arrLength;

  return arr.length;
};

/* ===========================================================================
 * SUM - the sum of the numbers in a list
       - safe to assume that all items are numbers already
 *
 * For example:
 *
 *    sum([6,2,3,4,9,6,1,0,5])
 *
 * Returns:
 *
 *    36
 */
const sum = function(arr) {
  // create a space to hold the running total
  let runningTotal = 0;

  // loop through the provided array (look at each element of the provided array)
  arr.forEach((num) => {
    // get the individual element and add it to the running total
    runningTotal += num;
  });

  // for (const num of arr) {
  //   runningTotal += num;
  // }

  // return the running total
  return runningTotal;
};

// To be used by mean. Do not alter.
const round = function(number) {
  return Math.round(number * 100) / 100;
};

// 3.141587
// 314.1587
// 314
// 3.14

/* ===========================================================================
 * MEAN - the average value of numbers in a list
 *      - use the provided 'round' function when returning your value
 *      - if empty array, return null to indicate that mean cannot be calculated
 *
 * For example:
 *
 *    mean([6,2,3,4,9,6,1,0,5])
 *
 * Returns:
 *
 *    4
 */
const mean = function(arr) {
  // edge cases
  if (arr.length === 0) {
  // if (!arr.length) {
    return null;
  }

  // average = sumOfNumbers / numOfNumbers
  const sumOfNumbers = sum(arr);
  const numOfNumbers = count(arr);

  const average = sumOfNumbers / numOfNumbers;

  const roundedAverage = round(average);

  return roundedAverage;
};

// Don't change below:
module.exports = { count, sum, mean };
