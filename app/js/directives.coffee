angular.module('pandoc.directives', [])
    .directive 'syntax', ->
        return (scope, elem, attrs) ->
            codeMirror = CodeMirror.fromTextArea elem[0],
                mode: 'markdown'
            console.log 'syntax attached to', elem
