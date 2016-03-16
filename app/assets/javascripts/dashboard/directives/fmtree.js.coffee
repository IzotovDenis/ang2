dashboard.directive "fmtree", ->
	restrict: "E"
	transclude: true
	scope: {
		array: "="
	}
	link: (scope, element, attrs, $scope) ->
		template = '<ul>'
		render = ->
			angular.forEach(scope.array, (value) ->
				template  += '<li ng-click="selectFolder(value)">' + value.name + '</li>'
				console.log(value)
			)
			template += '</ul>'
			element.html template

		watch = scope.$watch (->
			scope.array), ((newVal,oldVal) ->
				render()
				)