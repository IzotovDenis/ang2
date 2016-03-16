dashboard.controller "UsersShowCtrl", UsersEditCtrl = ["$scope", "$http", "$routeParams", "$location", ($scope, $http, $routeParams, $location) ->

	$scope.user = []
	$scope.activities = []
	$scope.orders = []

	$http.get('api/users/' + $routeParams.userId).success (data) ->
		$scope.user = data


	$scope.editUser = (id) ->
		$location.url("users/" + id + "/edit")

	$scope.updateRole = ->
		$http.post("api/users/update_role", {id: $scope.user.id, role: $scope.user.role, confirm: $scope.user.mailConfirm}).success (data) ->
			alert("Сохранено")

	$scope.loadActivities = ->
		$http.get('api/activities?user_id='+$routeParams.userId).success (data) ->
			$scope.activities = data.activities

	$scope.loadCurrentOrder = ->
		$http.get('api/orders/' + $routeParams.userId + "?current=true").success (data) ->
			$scope.order = data
			$scope.order.amount = 0
			angular.forEach(data.items, (value) ->
				$scope.order.amount += value.ordered*value.price
			)

	$scope.loadOrders = ->
		$http.get('api/orders?user_id='+$routeParams.userId).success (data) ->
			$scope.orders = data
]