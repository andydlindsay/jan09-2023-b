const net = require('net');

const config = {
  host: 'localhost',
  port: 3000
};

// need to provide ip and port
const conn = net.createConnection(config);

// set the character encoding on the connection
conn.setEncoding('utf-8');

// listen for an incoming message
conn.on('data', (data) => {
  // console.log('we got a message from the server!');
  console.log('server said: ', data);
});

// listen for the close event (socket connection terminates)
conn.on('close', () => {
  console.log('connection was terminated by the server');
});

// send a message to the server
setInterval(() => {
  conn.write('it is nice to be here!');
}, 500);

// set the encoding on stdin
// process.stdin.setEncoding('utf-8');

// // listen for input from stdin
// process.stdin.on('data', (data) => {
//   // console.log('you just typed: ', data);
//   conn.write(data);
// });
