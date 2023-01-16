// pull in whichever assert library you'd like to use
const chai = require('chai');  
const assert = chai.assert;

// pull in the main functions that will be tested
const helper = require('../hello-world');


// write the mocha describe() and it() function calls that will implement the test(s)

it('will give an opinion about AI', () => {
  const actual = helper.giveOpinionOn('AI');
  const expected = 'I feel that AI is going to make testing frameworks even more important.';
  assert.equal(actual, expected);
});

describe('polite protocol communications', ()=> {
  it('says hello in the way we expect', () => {
    const actual = helper.sayHello('World');
    const expected = 'Hello, World!';
    assert.equal(actual, expected);
  });
  
  it('says goodbye in the way we expect', () => {
    const actual = helper.sayGoodbye('Mickey Mouse');
    const expected = 'Goodbye, Mickey Mouse!';
    assert.equal(actual, expected);
  });
});


