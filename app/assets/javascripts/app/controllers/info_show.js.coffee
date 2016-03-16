app.controller "InfoShowCtrl", InfoShowCtrl = ["$scope", "$http", "Item", "Order", "OrderItem", "System", "$location", "$routeParams", "$modal", "Page", "$sce", ($scope, $http, Item, Order, OrderItem, System, $location, $routeParams, $modal, Page, $sce) ->
	
	$http.get("/api/posts/"+$routeParams.page).success (data) ->
		$scope.post = data
		$scope.text = $sce.trustAsHtml(data.text)
		Page.setTitle(data.title)
	
	Item.list = []
]