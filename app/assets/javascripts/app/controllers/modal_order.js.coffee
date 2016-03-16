app.controller "ModalOrderCtrl", ModalOrderCtrl = ["$scope", "$modalInstance", "Order", "$http", "$window", "$timeout", ($scope, $modalInstance, Order, $http, $window, $timeout) ->

	$scope.order = Order
	$scope.order.current = {}
	$scope.itemList = []

	getOrder = ->
		Order.getCurrent()

	$timeout(getOrder, 500)

	$scope.addToCart = (item) ->
		unless item.busy
			update = true
			i = 0
			while i < Order.itemIds.length
				if item.id == Order.itemIds[i].item_id
					if item.ordered.toString() != Order.itemIds[i].qty.toString()
						update = true
						break
					else
						update = false
						break
				else
					update = true
				i++
			if update
				item.busy = true
				Order.itemAdd(item).then (->
					item.busy = false
					Order.calcAmount
				), (reason) ->
					item.busy = false

	$scope.deleteItem = (item) ->
		items = [item]
		Order.deleteFromCart(items)
		Order.calcAmount

	$scope.checkAll = (val) ->
		angular.forEach($scope.order.current.items, (value) ->
			value.checked = val
		)

	$scope.deleteItems = (items) ->
		console.log(items)

	$scope.closeModal = ->
		$modalInstance.close()

	$scope.forwardOrder = ->
		$http.post('api/orders/forwarding', comment: $scope.orderComment).success (data) ->
			if data.status == "success"
				$modalInstance.close()
				$window.alert("Заказ успешно отправлен!")
				Order.getCurrent().then	((res) ->
					Order.current = res
					Order.itemIds = [])
			else
				$window.alert("Ошибка при отправке!")
				console.log("SOME ERROR")

	$scope.deleteItems = ->
		arr = []
		empty = true
		angular.forEach($scope.order.current.items, (value) ->
			if value.checked == true
				arr.push(value)
				empty = false
		)
		if empty == false
			Order.deleteFromCart(arr)
]