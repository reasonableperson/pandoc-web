# Controllers

angular.module 'pandoc.controllers',
    # dependencies
    ['ui.codemirror', 'LocalStorageModule', 'ngSanitize']

.controller('pandoc-web', [
    '$scope', '$element', 'localStorageService', '$sanitize', '$location'
    (scope, elem, storage, $sanitize, location) ->

        scope.location = location

        # pull documents out of local storage
        scope.documents = storage.get 'documents'
        if !scope.documents?
            console.log 'no documents found'
            scope.documents = [{name: 'example', markdown: '# Markdown view'}]
            storage.add 'documents', scope.documents
        else
            console.log scope.documents.length + ' documents found.'

        # select current document
        scope.doc = scope.documents[0]
        console.log 'current doc', scope.doc

    ])

.service 'showdown', ->
    html = ''
    source = ''
    converter = new Showdown.converter()
    return {
        convert: (markdown) ->
            source = markdown
            html = converter.makeHtml markdown
        html: -> html
        source: -> source
    }

.controller('markdown', [
    '$scope', '$element', 'localStorageService', '$sanitize',
    '$location', 'showdown',
    (scope, elem, storage, $sanitize, location, showdown) ->
        # codemonitor: highlight markdown and render on change
        scope.cmOptions =
            mode: 'markdown'
            theme: 'solarized'
            onChange: ->
                showdown.convert scope.doc.markdown
        scope.cmOptions.onChange()

        scope.save = ->
            scope.doc.lastSaved = new Date()
            storage.add 'documents', scope.documents

        scope.render = ->
            console.log scope.doc

        scope.new = ->
            scope.documents.push
                name: scope.newDoc
                markdown: "Add content to your new document..."
])

.controller('html', ['$scope', 'showdown', (scope, showdown) ->
    scope.showdown = showdown
])

.controller('pdf', ['$scope', '$http', 'showdown', (scope, http, showdown) ->
    console.log 'pdf controller'
    scope.url = 'tmp/a62315ff07c69bdb9e9e58ea6d32a759.pdf'
    scope.renderPdf = ->
        console.log 'rendering...'
        http.post('render/pdf', {markdown: showdown.source()})
        .success (data, status, headers, config) ->
            console.log data
            scope.url = 'tmp/' + data + '.pdf'
        .error (data, status, headers, config) ->
            console.log data
            
])
