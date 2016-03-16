app.controller "OfferShowCtrl", OfferShowCtrl = ["$scope", "$http", "Item", "Order", "OrderItem", "$location", "$routeParams", "$modal", "Page", ($scope, $http, Item, Order, OrderItem, $location, $routeParams, $modal, Page) ->
	# Очищаем список товаров
	Item.list = []
	# Устанавлием "занят", отключая infinity-scroll пока не закгрузится новая страница
	Item.busy = true

	# Урл для загрузки товара, необходим для infinity-scroll
	url = "/api/offers/" + $routeParams.offerId

	# Загрузка акции
	$http.get(url).success (data) ->
		$scope.offer = data

		# Устанавливаем title страницы
		Page.setTitle($scope.offer.title)

		# Доавляем товары в фабрику
		Item.firstLoad(data.items, url)
]