const net = require('net');

// console.log(net);

const server = net.createServer();

server.listen(3000, () => {
  console.log('app is listening on port 3000');
});

const connections = [];

// write code that happens when someone connects
server.on('connection', (conn) => {
  // add the current connection to our array of connections
  connections.push(conn);

  // console.log(connections);

  console.log('someone has connected to the server!');

  // send a welcome message to the client
  conn.write('welcome to our chat room');

  // listen for messages from the client
  conn.on('data', (data) => {
    console.log('client says:', data);

    if (data.includes('Name:')) {
      console.log('this client wants to change their name');

      // Name: Alice\n
      const name = data.trim().split(' ')[1];
      conn.username = name;
    } else {
      for (const connection of connections) {
        // if this connection is not the one that sent the message
        if (connection !== conn) {
          connection.write(`${conn.username} says: ${data}`);
        }
      }
    }
  });

  // set the character encoding on the connection
  conn.setEncoding('utf-8');
});
