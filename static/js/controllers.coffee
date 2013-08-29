angular.module 'pandoc.controllers',
    # dependencies
    ['ui.codemirror', 'LocalStorageModule', 'ngSanitize', 'pandoc.services']

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

.controller('markdown', [
    '$scope', '$element', 'localStorageService', '$sanitize',
    '$location', 'pandocument',
    (scope, elem, storage, $sanitize, location, pandocument) ->
        # codemonitor: highlight markdown and render on change
        scope.cmOptions =
            mode: 'markdown'
            theme: 'solarized'
            onChange: ->
                pandocument.convert scope.doc.markdown
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

.controller('html', ['$scope', 'pandocument', (scope, pandocument) ->
    scope.pandocument = pandocument
])

.controller('pdf', ['$scope', '$http', 'pandocument', (scope, http, pandocument) ->
    console.log 'pdf controller'
    scope.url = 'tmp/a62315ff07c69bdb9e9e58ea6d32a759.pdf'
    scope.renderPdf = ->
        console.log 'rendering...'
        http.post('render/pdf', {markdown: pandocument.source()})
        .success (data, status, headers, config) ->
            console.log data
            scope.url = 'tmp/' + data + '.pdf'
        .error (data, status, headers, config) ->
            console.log data
            
])
