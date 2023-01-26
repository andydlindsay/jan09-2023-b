const bcrypt = require('bcrypt');

const plaintextPassword = 'abcd';


bcrypt.genSalt(10, function(err, salt) {
  console.log('salt', salt);
  bcrypt.hash(plaintextPassword, salt, function(err, hash) {
    console.log('hash:', hash);
  });
});

// bcrypt.genSalt(10)
//   .then((salt) => {
//     // console.log('salt', salt);
//     return bcrypt.hash(plaintextPassword, salt);
//   })
//   .then((hash) => {
//     // console.log('hash', hash);
//   });

const hash = '$2b$10$KeIw2gDjmlqAoalyrq.Os.GFsVCE1040CMIO.zaNoTAFWI6o0xX.i';

bcrypt.compare('abcdd', hash)
  .then((result) => {
    console.log('do the passwords match?', result);
  });
