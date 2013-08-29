angular.module 'pandoc.controllers',
    # dependencies
    ['ui.codemirror', 'LocalStorageModule', 'ngSanitize', 'pandoc.services']

.controller('pandoc-web', [
    '$scope', 'localStorageService', '$sanitize', '$location', 'pandocument',
    (scope, storage, $sanitize, location, pandocument) ->

        scope.location = location
        scope.pandoc = pandocument

        # pull documents out of local storage
        scope.documents = storage.get 'documents'
        if !scope.documents?
            console.log 'no documents found'
            scope.documents = [{name: 'example', markdown: '# Markdown view'}]
            storage.add 'documents', scope.documents
        else
            console.log scope.documents.length + ' documents found.'

        # select current document
        doc = scope.documents[0]
        pandocument.markdown = doc.markdown
        pandocument.name = doc.name
        pandocument.html = pandocument.converter.makeHtml doc.markdown
        console.log 'current pandoc', pandocument
        window.pd = pandocument

    ])

.controller('markdown', [
    '$scope', '$element', 'localStorageService', '$sanitize',
    '$location', 'pandocument',
    (scope, elem, storage, $sanitize, location, pandoc) ->
        # codemonitor: highlight markdown and render on change
        scope.cmOptions =
            mode: 'markdown'
            theme: 'solarized'
            onChange: ->
                pandoc.html = pandoc.converter.makeHtml pandoc.markdown
        scope.cmOptions.onChange()

        scope.save = ->
            scope.doc.lastSaved = new Date()
            storage.add 'documents', scope.documents

        scope.new = ->
            scope.documents.push
                name: scope.newDoc
                markdown: "Add content to your new document..."
])

.controller('html', ['$scope', 'pandocument', (scope, pandocument) ->
    scope.pandocument = pandocument
])

.controller('pdf', ['$scope', '$http', 'pandocument', (scope, http, pandocument) ->
    scope.renderPdf = ->
        console.log 'rendering...'
        http.post('render/pdf', {markdown: pandocument.markdown})
        .success (data, status, headers, config) ->
            pandocument.pdfUrl = 'tmp/' + data + '.pdf'
            console.log 'pdfUrl', pandocument.pdfUrl
        .error (data, status, headers, config) ->
            console.log data
])
