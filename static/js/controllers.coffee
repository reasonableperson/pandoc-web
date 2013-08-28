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
    converter = new Showdown.converter()
    return {
        convert: (markdown) ->
            html = converter.makeHtml markdown
        html: -> html
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

.controller('pdf', ['$scope', (scope) ->

    # console.log 'pdf controller'

])
