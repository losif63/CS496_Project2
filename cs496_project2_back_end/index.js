var mysql= require('mysql');

var connection = mysql.createConnection({
  host     : '172.10.5.148',
  user     : 'admin',
  port     : '3306',
  password : 'engage12!@',
  database : 'appdata'
});

connection.connect((err) => {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }
  console.log('connected as id ' + connection.threadId);
});

connection.query('SELECT * from users', (error, results, fields) => {
    if(error) throw error;
    console.log(results);
});

connection.end();
const express = require('express');
const app = express();

const https = require('https');
const sslServer = https.createServer({

});
// app.get('/', (req, res) => {
//     res.send('Hello World!');
//     console.log('Get Request!');
// })

// app.get('/adduser1', (req, res) => {
//     let user = {name: 'User1', profile_word: 'Salutations Everybody!!', profile_pic: '', user_id: 'user1', email: 'user1@salutations.com', birthdate: '2022/07/07'};
//     let sql = 'INSERT INTO users SET ?';
//     let query = connection.query(sql, user, (err, result) => {
//         if(err) throw err;
//         console.log(result);
//         res.send('User1 Added...');
//     });
// });

// app.get('/adduser2', (req, res) => {
//     let user = {name: 'User2', profile_word: 'Greetings Everyone!!', profile_pic: '', user_id: 'user2', email: 'user2@greetings.com', birthdate: '2022/07/07'};
//     let sql = 'INSERT INTO users SET ?';
//     let query = connection.query(sql, user, (err, result) => {
//         if(err) throw err;
//         console.log(result);
//         res.send('User2 Added...');
//     });
// });

// app.get('/getusers', (res, req) => {
//     let sql = 'SELECT * from users';
//     let query = connection.query(sql, (err, results) => {
//         if(err) throw err;
//         console.log(results);
//         req.send('Users fetched...');
//     });
// });

// app.listen('3000', () => {
//     console.log('Server started on port 3000');
// });