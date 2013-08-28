# initiate app
express = require 'express'
app = express()

# render stylus to CSS
app.use(require('stylus').middleware(__dirname + '/static'));

# render jade to HTML
app.set 'views', __dirname + '/partials'
app.engine 'jade', require('jade').__express

# static files
app.use express.static(__dirname + '/static')

pandoc = require 'pdc' 
app.use express.bodyParser()

# start app
PORT = 7793
app.listen PORT
console.log 'Express server listening on port ' + PORT + '.'

# routes

app.get '/', (req, res) ->
    res.render 'edit.jade'

app.post '/render/pdf', (req, res) ->
    console.log 'REQUEST', req.body
    ### console.log req.body.markdown
    opts = []
    result = ''
    pandoc req.body.markdown, 'markdown', 'pdf', opts,
        (err, result) ->
            if err is null then pdf = result
    res.return pdf
    ###       
    res.send req.body
