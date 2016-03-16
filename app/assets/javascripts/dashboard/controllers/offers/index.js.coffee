dashboard.controller "OffersIndexCtrl", OffersIndexCtrl = ["$scope", "$http", "$location", ($scope, $http, $location) ->

	$http.get("/dashboard/api/offers").success (data) ->
		$scope.offers = data

	$scope.destroyOffer = (id) ->
		$http.delete("/dashboard/api/offers/" + id).success (data) ->
			$scope.offers = data

]