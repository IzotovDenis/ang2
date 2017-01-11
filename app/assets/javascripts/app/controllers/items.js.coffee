app.controller "ItemsCtrl", ItemCtrl = ["$scope", "Item", "$modal", "Order", "$filter", "$location", "$routeParams", "System", ($scope, Item, $modal, Order, $filter, $location, $routeParams, System) ->

	$scope.OnlyInStock = System.OnlyInStock

	$scope.$on "$routeChangeStart", ->
		Item.fixedView = false
		Item.itemsPagin = false

	$scope.items = Item

	$scope.$watch (->
		Item.userView), ((newVal,oldVal) ->
			$scope.imageView = $scope.items.itemsView()
			)

	$scope.$watch (->
		Order.itemIds), ((newVal,oldVal) ->
			Item.setOrderQty()
			)

	if $routeParams.page
		$scope.currentPage = $routeParams.page

	$scope.pageChanged = ->
		a = $location.search()
		a['page'] = $scope.currentPage
		$location.search(a)

	$scope.showHead = ->
		$scope.items.list.length > 0

	$scope.imageSize = ->
		return "img_thumb"

	$scope.itemShow = (item) ->
		modalInstance = $modal.open(
			templateUrl: "items/modal.html"
			controller: "ModalItemCtrl"
			windowClass: 'modal-item'
			resolve:
				item: ->
					item
		)

	$scope.itemShowImage = (item) ->
		if item.image == 't'
			modalInstance = $modal.open(
				templateUrl: "items/modal_image.html"
				controller: "ModalImageCtrl"
				windowClass: 'modal-item'
				resolve:
					item: ->
						item
			)

	$scope.priceShow = (item) ->
		modalInstance = $modal.open(
			templateUrl: "items/modal_price.html"
			controller: "ModalPriceCtrl"
		)

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

	$scope.goFind = (query) ->
		$location.url('/find/' + query)

]