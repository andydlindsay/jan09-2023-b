/* Question 3
 *
 *  Implement the 'mode' function defined below
 *
 * MODE - the most frequently occurring number
 *      - for this test, the provided lists will only have a single value for the mode
 *
 * For example:
 *
 *    mode([6,2,3,4,9,6,1,0,5]);
 *
 * Returns:
 *
 *    6
 */

// { '8': 2, '6': 1 }
// [{ key: 8, value: 2}, {key: 6, value: 1}, [6, 2]]
const mode = function(arr) {
  // 1. create the piles
  // set aside space in memory to hold our "piles"
  const piles = {};

  // look at each element of the provided array
  for (const num of arr) {
    // have we seen this element before?
    if (piles[num]) {
      // if yes, add the "card" to the "pile"
      // piles[num] += 1;
      piles[num]++;
    } else {
      // if no, create a new pile starting at 1
      piles[num] = 1;
    }
  }

  // console.log our piles
  // console.log(piles);

  // 2. compare the piles
  // create a space in memory to hold highest value seen AND key assoc with highest value
  let highestValue = 0;
  let highestKey = null;

  // look at each pile in the piles object
  for (const key in piles) {
    // retrieve the value
    const value = piles[key];

    // is the value higher than our highest seen so far
    if (value > highestValue) {
      // if yes, replace the highest value AND key assoc with it
      highestValue = value;
      highestKey = key;
    }
  }

  // return the key assoc with the highest value
  return Number(highestKey);
};

// Don't change below:
module.exports = { mode };
