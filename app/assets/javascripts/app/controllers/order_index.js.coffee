app.controller "OrderIndexCtrl", OrderIndexCtrl = ["$scope", "$http", "$location", ($scope, $http, $location) ->
	$http.get("/api/orders").success (data) ->
		$scope.orders = data.orders
		$scope.orders_count = data.orders_count
		console.log($scope.orders)

	$scope.showOrder = (id) ->
		$location.url("/orders/"+id)

	$scope.pageChanged = ->
		$http.get("/api/orders?page="+$scope.currentPage).success (data) ->
			$scope.orders = data.orders
			$scope.orders_count = data.orders_count
			console.log($scope.orders)
]