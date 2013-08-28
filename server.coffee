# initiate app
express = require 'express'
app = express()

# render stylus to CSS
app.use(require('stylus').middleware(__dirname + '/static'));

# static files
app.use express.static(__dirname + '/static')

app.set 'views', __dirname + '/partials'
app.engine 'jade', require('jade').__express

# templates

# views
app.get '/', (req, res) ->
    res.render 'home.jade'
    
app.get '/from/markdown/to/html', (req, res, next) ->
    console.log 'not implemenetd'

# start app
PORT = 7793
app.listen PORT
console.log 'Express server listening on port ' + PORT + '.'
