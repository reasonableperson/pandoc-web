'use strict'

angular.module('pandoc', ['pandoc.controllers', 'pandoc.services', 'ui.codemirror'])
###
    .config ['$routeProvider', ($routeProvider) ->
        $routeProvider.when '/view1',
            templateUrl: 'partials/home.html',
            controller: 'MyCtrl1'
        $routeProvider.when '/view2',
            templateUrl: 'partials/partial2.html',
            controller: 'MyCtrl2'
        $routeProvider.otherwise
            redirectTo: '/view1'
    ]
###

window.location.hash = '#/html'
