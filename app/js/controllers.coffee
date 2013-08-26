# Controllers

angular.module('pandoc.controllers', ['ui.codemirror', 'LocalStorageModule', 'ngSanitize'])
    .controller 'markdown-compiler',
        ['$scope', '$element', 'localStorageService', '$sanitize',
        (scope, elem, storage, $sanitize) ->

            scope.render = -> scope.html = scope.converter.makeHtml scope.doc.code

            scope.cmOptions =
                mode: 'markdown'
                theme: 'solarized'
                onChange: scope.render

            scope.documents = storage.get 'documents'
            if !scope.documents?
                console.log 'no documents found'
                scope.documents = [{name: 'example', code: '# Markdown view'}]
                storage.add 'documents', scope.documents
            else
                console.log scope.documents.length + ' documents found.'

            scope.doc = scope.documents[0]
            console.log 'current doc', scope.doc

            # load and compile
            scope.converter = new Showdown.converter()
            scope.render()

            scope.save = ->
                scope.doc.lastSaved = new Date()
                storage.add 'documents', scope.documents

            scope.new = ->
                scope.documents.push
                    name: scope.newDoc
                    code: "Add content to your new document..."

        ]
