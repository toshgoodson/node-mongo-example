# Message schema and model
mongoose = require 'mongoose'

messageSchema = mongoose.Schema {
    author: String,
    body: String,
    date: { type: Date, default: Date.now }
}

module.exports = {
	Message: mongoose.model 'Message', messageSchema
}