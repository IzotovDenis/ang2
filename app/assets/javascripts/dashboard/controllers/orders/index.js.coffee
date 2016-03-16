dashboard.controller "OrdersIndexCtrl", OrdersIndexCtrl = ["$scope", "$http", "$location", "$filter", ($scope, $http, $location, $filter) ->
	$scope.period = {}
	$scope.period.date = new Date()
	$scope.period.range = "day"
	$scope.$watchCollection "period", (newValue, oldValue) ->
		$scope.date = $filter('date')(newValue.date,'yyyy-MM-dd')
		$http.get("/dashboard/api/orders?date="+$scope.date+"&period="+newValue.range).success (data) ->
			$scope.orders = data

]