app.controller "MainCtrl", MainCtrl = ["$scope","$http", "Group", "User", "Order", "System",  "$location", "$modal", "Page", "$window", "$timeout", "$route", "Banner", ($scope, $http, Group, User,Order, System, $location, $modal, Page, $window, $timeout, $route, Banner) ->
	
	# Привязываем фабрики
	$scope.order = Order
	$scope.user = User
	$scope.title = Page
	$scope.banners = Banner.list

	$scope.groups = Group

	# Может ли пользователь видеть цены, оформлять заказы?
	$scope.canOrder = ->
		User.can_order

	$scope.OnlyInStock = System.OnlyInStock

	$scope.toggleStock = ->
		System.toggleInStock()
		$route.reload()

	$scope.newQuery = {}

	# Метод установки скидки
	$scope.setDiscount = (value) ->
		User.setDiscount(value)

	# Получить текущего пользователя

	$scope.$on "$routeChangeStart", ->
	  $scope.aa = false

	# Метода поиска
	$scope.enterFind = (newQuery) ->
		unless (newQuery.query == undefined || newQuery.query.length == 0)
			query = "query=" + newQuery.query
			if newQuery.group
				query += "&group=" + System.group.id
			if newQuery.attr
				query += "&attr=" + newQuery.attr
			$location.url('/find?' + query)


	# Что то для работы с модалью заказа
	# TODO: разобраться, переименовать
	$scope.open = ->
	  modalInstance = $modal.open(
	    templateUrl: "modal.html",
	    controller: "ModalOrderCtrl",
	    windowClass: 'modal-order',
	    animation: false
	  )

	# Кнопка скачать прайс-лис
	$scope.downloadPricelist = ->
		if $scope.canOrder()
			$window.location.replace("pricelist.zip")
		else
			modalInstance = $modal.open(
				templateUrl: "items/modal_price.html"
				controller: "ModalPriceCtrl"
			)


	# Показать выбранную группу меню
	# TODO: скрывать другие открытые ветки 
	$scope.showSelected = (sel) ->
		if sel
			$scope.newQuery.group = false
			$location.url('/groups/' + sel.id)

	# Настрокий дерева меню
	$scope.treeOptions = {
	    nodeChildren: "children",
	    dirSelectable: false,
	    injectClasses: {
	        ul: "nav nav-pills nav-stacked nav-tree",
	        li: "",
	        liSelected: "a7",
	        iExpanded: "a3",
	        iCollapsed: "a4",
	        iLeaf: "a5",
	        label: "a6",
	        labelSelected: "a6"
	    }
	}

	$scope.relS = ->
		$route.reload()
]