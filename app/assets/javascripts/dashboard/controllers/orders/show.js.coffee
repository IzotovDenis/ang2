dashboard.controller "OrdersShowCtrl", OrdersShowCtrl = ["$scope", "$http", "$location", "$routeParams", ($scope, $http, $location, $routeParams) ->

	$http.get("/dashboard/api/orders/" + $routeParams.orderId).success (data) ->
		$scope.order = data
]