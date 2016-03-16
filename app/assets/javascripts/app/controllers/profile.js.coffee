app.controller "ProfileCtrl", ProfileCtrl = ["$scope", "$http", "$location","$window", ($scope, $http, $location, $window) ->
	$http.get("/api/users?r="+Math.random())
		.success (data) ->
			$scope.user = data
			$scope.profileSys = []
			$scope.pswd = []
		.error (error, status) ->
			if status == 401
				$location.path("/")

	$scope.updateProfile = ->
		$http.patch("/api/users/"+$scope.user.id, user: $scope.user).success (data) ->
			$scope.user = data.user
			if data.errors && data.errors.length > 0
				$scope.profileSys.errors = data.errors
				$scope.profileSys.success = false
			else
				$scope.profileSys.errors = ""
				$scope.profileSys.success = true

	$scope.updatePassword = ->
		console.log($scope.newpass)
		$http.patch("/api/users/update_password", pswd: $scope.newPassword).success (data) ->
			if data.errors && data.errors.length > 0
				$scope.profileSys.errors = data.errors
				$scope.profileSys.success = false
			else
				$scope.profileSys.errors = ""
				$scope.profileSys.success = true
]