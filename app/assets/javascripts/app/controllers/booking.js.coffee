app.controller "BookingCtrl", BookingCtrl = ["$scope", "$http", "$location", "$routeParams", "$modal", "Page", ($scope, $http, $location,  $routeParams, $modal, Page) ->
	$scope.FindBookingItems = () ->
		url = "/api/booking?query=" + $scope.query
		$http.get(url).success((data) ->
			$scope.success = data["success"]
			if $scope.success
				$scope.parts = data["list"]
				$scope.crosses = data["crosses"]
				console.log($scope.crosses)
			)

	# Устанавливаем h1 страницы
	$scope.title = "Результат поиска " + $routeParams.query
	# Устанавливаем титл страницы
	Page.setTitle("Поиск " + "\"" + $routeParams.query + "\"")
]
