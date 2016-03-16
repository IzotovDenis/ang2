app.controller "ModalItemCtrl", ModalItemCtrl = ["$scope", "$modalInstance", "item", "Order", "$filter", "$http","$modal", ($scope, $modalInstance, item, Order, $filter, $http, $modal) ->
	$scope.item = item
	if item.ordered
		$scope.ordered = item.ordered
		$scope.orderitem_id = item.orderitem_id

	$http.get("/api/items/"+$scope.item.kod).success (data) ->
		if data.certificate && data.certificate.match(/doc&id=([0-9]*)/)
			id = data.certificate.match(/doc&id=([0-9]*)/)[1]
			data.certificate = "http://disk.planeta-avtodv.ru/docs/"+id
		$scope.item = data
		if $scope.ordered
			$scope.item.ordered = $scope.ordered
			$scope.item.orderitem_id = $scope.orderitem_id

	$scope.addToCart = (item) ->
		unless item.busy
			update = true
			i = 0
			while i < Order.itemIds.length
				if item.id == Order.itemIds[i].item_id
					if item.ordered != Order.itemIds[i].qty
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
				), (reason) ->
					item.busy = false

	$scope.inCart = (id) ->
		found = $filter('getById')(Order.itemIds, id)
		if found
			true

	$scope.closeModal = ->
		$modalInstance.close()
		
	$scope.$on "$routeChangeStart", ->
	  $modalInstance.close()

	$scope.itemShowImage = (item) ->
		modalInstance = $modal.open(
			templateUrl: "items/modal_image.html"
			controller: "ModalImageCtrl"
			windowClass: 'modal-item'
			resolve:
				item: ->
					item
		)
]