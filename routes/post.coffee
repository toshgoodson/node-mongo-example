exports.index = (req, res) -> 
	# open a connection to the database
	mongoose = require 'mongoose'
	db = mongoose.connection
	# handle connection errors
	db.on 'error', console.error.bind(console, 'connection error:')

	console.log req.body
	# test
	# messageModel = require '../models/message.js'
	# message = new messageModel.Message({ author: 'Tosh', body: 'Hello world.' })
	# message.save (err, message) -> if err then console.log "Error saving message!"

	res.render 'index', { title: 'Express' }