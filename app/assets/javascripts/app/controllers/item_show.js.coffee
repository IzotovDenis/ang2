app.controller "ItemShowCtrl", ItemShowCtrl = ["$scope", "$http", "$routeParams", "$modal", "Order", "$filter", ($scope, $http, $routeParams, $modal, Order, $filter) ->
	$http.get("/api/items/"+$routeParams.itemId).success (data) ->

		$scope.item = data

	$scope.addToCart = (item) ->
		console.log("start")
		new_order_item = {
			item_id: item.id,
			qty: item.ordered
		}
		if item.orderitem_id
			Order.updateInCart(new_order_item, item.orderitem_id)
		else
			Order.addToCart(new_order_item)

	$scope.inCart = (kod) ->
		found = $filter('getById')(Order.itemList, kod)
		if found
			true
]