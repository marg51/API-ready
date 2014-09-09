config = require('./config').config

elasticsearch = require('elasticsearch')
client = new elasticsearch.Client({
  host: 'localhost:9200'
})

exports.client = client