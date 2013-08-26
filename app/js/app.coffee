'use strict'

# Declare app level module which depends on filters, and services
angular.module('pandoc', ['pandoc.filters', 'pandoc.services', 'pandoc.directives', 'pandoc.controllers'])
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
