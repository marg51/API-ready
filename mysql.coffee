config = require('./config').config

mysql      = require('mysql')
connection = mysql.createConnection({
  host     : 'localhost',
  user     : config.user,
  password : config.password,
  database : config.database
})

connection.connect()

exports.connection = connection