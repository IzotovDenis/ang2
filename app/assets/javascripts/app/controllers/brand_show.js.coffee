app.controller "BrandShowCtrl", BrandShowCtrl = ["$scope", "$http", "$routeParams", "Item", "$location", ($scope, $http, $routeParams, Item, $location) ->

	$scope.groups = []
	# Урл для запросов infinity-scroll
	url = "api/brands/"+ $routeParams.brandId
	if $routeParams.group_id
		url = url + "?group_id=" + $routeParams.group_id

	$scope.$watch (->
		$scope.group), ((newVal,oldVal) ->
			if newVal
				if newVal != oldVal
					$location.url("/brands/"+ $routeParams.brandId+"?group_id="+ newVal)
			)

	$http.get(url).success (data) ->
		$scope.brand = data.brand
		$scope.groups = data.groups
		Item.firstLoad(data.items, url)
]