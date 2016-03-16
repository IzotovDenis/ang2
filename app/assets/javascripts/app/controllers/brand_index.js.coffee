app.controller "BrandIndexCtrl", BrandIndexCtrl = ["$scope", "$http", ($scope, $http) ->

	$http.get("api/brands").success (data) ->
		$scope.brands = data		
]