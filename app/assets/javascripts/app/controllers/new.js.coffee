app.controller "NewestCtrl", NewestCtrl = ["$scope", "$http", "Item", "Order", "OrderItem", "System", "$location", "$routeParams", "$modal", "Page", "$q", "Banner", ($scope, $http, Item, Order, OrderItem, System, $location, $routeParams, $modal, Page, $q, Banner) ->

	# Очищаем список товаров
	Item.list = []
	# Устанавлием "занят", отключая infinity-scroll пока не закгрузится новая страница
	Item.busy = true
	# Показываем контроль панель в группах
	Item.itemsControl = false
	Item.itemsPagin = false
	
	# Урл для запросов infinity-scroll
	url = "/api/items/newest"
	if $routeParams.page
		url = url + "?page="+$routeParams.page

	# Отправляемся запрос
	canceler = $q.defer()
	$http.get(url).success (data) ->
		# Записываем группу в скоуп
			Item.firstLoad(data.items, url, data.total_items)
		
]