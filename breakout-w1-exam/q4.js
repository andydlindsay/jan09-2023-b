/* Question 4
 *
 *  Implement the 'stdev' function defined below
 *
 * STDEV  - the square root of the average of the squared deviations of the values from their average value
 *        - The formula is:
 *
 *          stdev = sqrt(sum((x - populationMean)^2)/numberOfValues)
 *          cube = length * width * height
 *
 *        - you are allowed to look at Wikipedia's example calculation to help you understand the formula
 *        - Keep in mind, we are using 'Population Standard Deviation' as opposed to 'Sample Standard Deviation' for this test
 *            https://en.wikipedia.org/wiki/Standard_deviation#Population_standard_deviation_of_grades_of_eight_students
 *
 *        - use the provided 'round' function before returning your final value
 *        - you can take a square root using `Math.sqrt(number)`
 *
 * For example:
 *
 *    stdev([6,2,3,4,9,6,1,0,5]);
 *
 * Returns:
 *
 *    2.67
 */

// This function is to be used by stdev. Do not alter.
const round = function(number) {
  return Math.round(number * 100) / 100;
};

const q0Funcs = require('./q0');
const sum = q0Funcs.sum;

const stdev = function(arr) {
  // sqrt(sum((element - populationMean)^2)/numberOfValues)
  const numberOfValues = arr.length;
  const populationMean = sum(arr) / numberOfValues;

  // const differences = [];
  // for (const element of arr) {
  //   const difference = element - populationMean;
  //   differences.push(difference);
  // }

  const differences = arr.map((element) => {
    const difference = element - populationMean;
    return difference;
  });

  // console.log(arr);
  // console.log(populationMean);
  // console.log(differences);

  // const squares = [];
  // for (const difference of differences) {
  //   const square = Math.pow(difference, 2);
  //   squares.push(square);
  // }

  const squares = differences.map((difference) => {
    const square = Math.pow(difference, 2);
    return square;
  });

  // console.log(squares);

  const squareSum = sum(squares);

  // sqrt(sum((element - populationMean)^2)/numberOfValues)
  const squareAvg = squareSum / numberOfValues;
  const squareRoot = Math.sqrt(squareAvg);

  return round(squareRoot);
};

// Don't change below:
module.exports = { stdev };
