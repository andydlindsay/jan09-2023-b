const pg = require('pg');

// const Client = pg.Client; // single connection to rdbms
// const Pool = pg.Pool; // "managed" collections of clients (5)

const Client = pg.Client;

const config = {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME
};

const client = new Client(config);

client.connect();

module.exports = client;
