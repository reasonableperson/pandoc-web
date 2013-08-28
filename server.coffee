# initiate app
express = require 'express'
app = express()

# render stylus to CSS
stylus = require 'stylus'
app.use stylus.middleware
    debug: true
    src: __dirname + '/app/css'
    dest: __dirname + '/app/css'
    compile: (str) ->
        return stylus(str).set 'compress', true

# static files
app.use express.static(__dirname + '/app')

app.set 'views', __dirname + '/app/partials'
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
