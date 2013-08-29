angular.module('pandoc.services', [])

.service 'pandocument', ->
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
