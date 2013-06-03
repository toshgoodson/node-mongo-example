exports.index = (req, res) -> 
	# open a connection to the database
	mongoose = require 'mongoose'
	db = mongoose.connection
	# handle connection errors
	db.on 'error', console.error.bind(console, 'connection error:')

	#console.log req.body.author
	# test
	messageModel = require '../models/message.js'
	messageModel.Message.find { author: req.body.author }, 'author body date', (err, messages) ->
		res.json 200, messages