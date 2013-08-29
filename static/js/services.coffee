angular.module('pandoc.services', [])

.service 'pandocument', ->
    return {
        converter: new Showdown.converter()
        name: null
        html: null
        markdown: null
        pdfUrl: null
    }
