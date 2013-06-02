
# 
# Module dependencies.
#

express = require 'express' 
routes = require './routes' 
user = require './routes/user'
post = require './routes/post'  
http = require 'http' 
path = require 'path'
mongoose = require 'mongoose'

app = express()

# all environments
app.set 'port', process.env.PORT or 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static path.join __dirname, 'public'

mongoose.connect 'mongodb://localhost/messagelog'

# development only
if 'development' == app.get 'env'
	app.use express.errorHandler()

app.get '/', routes.index
app.get '/users', user.list
app.post '/post', post.index

http.createServer(app).listen app.get('port'), -> console.log 'Express server listening on port ' + app.get('port')
