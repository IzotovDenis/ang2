app.controller "GroupIndexCtrl", GroupIndexCtrl = ["$scope", "$http", "Item", "Order", "OrderItem", "$location", "$routeParams", "$modal", "System", "Page", "$q", "Banner", ($scope, $http, Item, Order, OrderItem, $location, $routeParams, $modal, System, Page, $q, Banner) ->
	
	# Очищаемся System.group для скрытия чекбока "Искать в группе"
	System.group = {}
	$scope.showMain = false

	# Делаем вид главной страницы плиткой
	Item.fixedView = "thumbs"

	# Убираем контроль панель на главной
	Item.list = []
	Item.itemsControl = false
	Item.itemsPagin = false

	$scope.banners = Banner.list

	# Устанавливаем стандартный титл страницы
	Page.setDefaultTitle()
	# Запрос на получения данныйх для главной страницы
	canceler = $q.defer()
	$http.get("/api/groups", {timeout: canceler.promise}).success (data) ->
		# Устанавливаем товары
		Item.setItems(data.items)
		# Записываем карусель
		Banner.setBanners(data.banners)
		# Записываем новинки, акции, предложения
		$scope.offers = data.offers
		$scope.showMain = true

	$scope.$on "$routeChangeStart", ->
		canceler.resolve()
]