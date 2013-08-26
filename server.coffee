express = require('express')
app = express()

# static files
app.use express.static(__dirname + '/app')

# templates
jade = require('jade')
fs = require('fs')

# helper for rendering a standard page
renderTemplate = (tpl, options) ->
    # locate template directory
    filename = __dirname + '/app/partials/' + tpl + '.jade'
    # compile template function
    template = jade.compile fs.readFileSync( filename ),
        filename: filename
        layout: false
        pretty: true
    # execute template and return html
    template options

# views
app.get '/', (req, res) ->
    opts =
        contents: 'abc'
    html = renderTemplate 'home', {}
    res.send(html)
    next()
    
app.get '/from/markdown/to/html', (req, res, next) ->
    console.log 'not implemenetd'

# start app
PORT = 7793
app.listen PORT
console.log 'Express server listening on port ' + PORT + '.'
