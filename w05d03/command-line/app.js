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
// console.log(process.argv);

const verb = process.argv[2];
// console.log('verb', verb);
const id = process.argv[3];
// "console.log('hello')"

switch (verb) {
  case 'browse':
    client.query('SELECT * FROM movie_villains ORDER BY id;')
      .then((response) => {
        console.log(response.rows);
        client.end();
      });
    break;

  case 'read':
    client.query(`SELECT * FROM movie_villains WHERE id = $1`, [id])
      .then((response) => {
        console.log(response.rows);
        client.end();
      });
    break;

  case 'edit':
    const newName= process.argv[4];
    client.query('UPDATE movie_villains SET villain = $1 WHERE id = $2;', [newName, id])
      .then(() => {
        console.log('villain has been updated successfully');
        client.end();
      })
    break;

  case 'add':
    const newVillain = process.argv[3];
    const newMovie = process.argv[4];

    const query = 'INSERT INTO movie_villains (villain, movie) VALUES ($1, $2);';

    client.query(query, [newVillain, newMovie])
      .then(() => {
        console.log(`Disney+ is creating a solo series for ${newVillain}`);
        client.end();
      });
    break;

  case 'delete':
    client.query('DELETE FROM movie_villains WHERE id = $1;', [id])
      .then(() => {
        console.log('villain was vanquished');
        client.end();
      });
    break;

  default:
    console.log('please use a valid BREAD verb');
    client.end();
}






