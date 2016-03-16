dashboard.controller "UsersEditCtrl", UsersEditCtrl = ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->

	$http.get('api/users/' + $routeParams.userId).success (data) ->
		$scope.user = data

	$scope.updateProfile = ->
		$http.patch("api/users/"+$scope.user.id, user: $scope.user).success (data) ->
			$scope.user = data.user
			if data.errors && data.errors.length > 0
				$scope.profileSys.errors = data.errors
				$scope.profileSys.success = false
			else
				$scope.profileSys.errors = ""
				$scope.profileSys.success = true
]