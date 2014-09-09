restify = require('restify')
http = require('http')
config = require('./config').config


server = restify.createServer
	name:'API ready'
	version: '0.0.1'

server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()
	
###server.get 'api.php', (req, res, next) ->
	res.send req.params###

# trigger another HTTP query
###
server.post 'do.php', (req, res, next) ->

	options = 
		host: 'localhost'
		port: config.port
		headers: {}
		path: 'api.php?params=q'
		method: 'GET'

	request = http.request options, (result) ->
		if result.statusCode isnt 200
			res.send {statusCode:result.statusCode}
			console.log result.headers
			console.log options
			return

		data = ""

		result.on "data", (chunk) ->
			data+= chunk.toString()


		# send the result of the HTTP response to the client
		result.on "end", ->
			res.send data

	request.on 'error', (e) ->
		console.log "error",e
	request.end()
###

# MySQL 
###
MySQL = require('./mysql').connection
server.get '/sql.json', (req, res, next) ->
	connection.query 'SELECT * FROM table where id = 1', (err, rows, fields) ->
		console.log err if err
		res.end('Hello World\n')
###

# ElasticSearch
# http://www.elasticsearch.org/guide/en/elasticsearch/client/javascript-api/current/api-reference.html
###
ES = require('./elasticsearch').client
server.get '/elasticsearch.json', (req, res, next) ->
	ES.get(index: 'index', type:'type', id: 1).then (body) ->
		console.log arguments
###


server.listen config.port, ->
	console.log 'localhost:'+config.port
