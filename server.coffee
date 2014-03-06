restify = require('restify')
http = require('http')
config = require('./config').config

server = restify.createServer
	name:'API ready'
	version: '0.0.1'

server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()
		
server.get 'api.php', (req, res, next) ->
	res.send req.params

server.post 'do.php', (req, res, next) ->

	options = 
		host: 'localhost'
		port: config.port
		headers: {}
		path: 'api.php?params=q'

	request = http.request options, (result) ->
		if result.statusCode isnt 200
			res.send {statusCode:result.statusCode}
			console.log result.headers
			console.log options
			return

		data = ""

		result.on "data", (chunk) ->
			data+= chunk.toString()


		result.on "end", ->
			res.send data

	request.on 'error', (e) ->
		console.log "error",e
	request.end()


server.listen config.port, ->
	console.log 'lookup-api.uto.io, localhost:'+config.port
