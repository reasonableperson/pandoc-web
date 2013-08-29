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

crypto = require 'crypto'
app.post '/render/pdf', (req, res) ->
    console.log 'REQUEST', req.body
    md5 = crypto.createHash 'md5'
    md5.update req.body.markdown
    hash = md5.digest 'hex'
    filename =  'static/tmp/' + hash + '.pdf'
    templateVariables =
        court: "In The Federal Court of Australia"
        "party1-name": "Jarndyce"
        "party2-name": "Jarndyce"
    opts = [
        '--latex-engine', 'xelatex',
        # '--template', 'tex/courtdoc.template.tex',
        '-o', filename,
    ]
    pandoc req.body.markdown, 'markdown', 'latex', opts,
        (err, result) ->
            console.log err, result, hash
            if err is null
                res.send hash
            else
                res.send 500, err
