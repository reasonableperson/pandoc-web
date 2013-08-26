angular.module('pandoc.directives', [])
    .directive 'syntax', ->
        ###
        return (scope, elem, attrs) ->
            scope.codeMirror = CodeMirror.fromTextArea elem[0],
                mode: 'markdown'
                theme: 'solarized'
            console.log 'codemirror:', scope.codeMirror
            ### 
