dashboard.controller "UsersIndexCtrl", UsersIndexCtrl = ["$scope", "$http", "$location", ($scope, $http, $location) ->
	$scope.sort = "name"

	$http.get('api/users/').success (data) ->
		$scope.users = data

	$scope.showUser = (id) ->
		$location.url('users/' + id)

	$scope.showUsers = (role) ->
		$http.get('api/users?role='+role).success (data) ->
			$scope.users = data

	$scope.$watch "sort", (newValue, oldValue) ->
		$scope.predicate = newValue

	$scope.changeReverse = ->
		$scope.reverse = !$scope.reverse
]