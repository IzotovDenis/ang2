dashboard.controller "PricelistsIndexCtrl", PricelistsIndexCtrl = ["$scope", "$http", "$location", ($scope, $http, $location) ->

	getPricelistInfo = ->
		$http.get("/dashboard/api/pricelist").success (data) ->
			$scope.pricelistInfo = data

	getPricelistInfo()

	
]