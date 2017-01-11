app.controller "GroupCtrl", GroupCtrl = ["$scope", "$http", "Item", "Order", "OrderItem", "System", "$location", "$routeParams", "$modal", "Page", "$q", "Banner", ($scope, $http, Item, Order, OrderItem, System, $location, $routeParams, $modal, Page, $q, Banner) ->
	
	# Очищаем список товаров
	Item.list = []
	# Устанавлием "занят", отключая infinity-scroll пока не закгрузится новая страница
	Item.busy = true
	# Показываем контроль панель в группах
	Item.itemsControl = false
	Item.itemsPagin = false

	$scope.OnlyInStock = System.OnlyInStock


	
	# Урл для запросов infinity-scroll
	url = "/api/groups/" + $routeParams.groupId + "?instock="+$scope.OnlyInStock
	if $routeParams.page
		url = url + "&page="+$routeParams.page

	$scope.groups.setGroup($routeParams.groupId)
	
	# Отправляемся запрос
	canceler = $q.defer()
	$http.get(url, {timeout: canceler.promise}).success (data) ->
		# Записываем группу в скоуп
		$scope.group = data.group
		# Записываем первые товары в фабрику
		Item.firstLoad(data.items, url, data.total_entries)

		# Записываем текущую группу в сустем для отображения чекбока "искать в группе"
		System.group = {}
		System.group.id = $scope.group.id
		System.group.title = $scope.group.title

		# Устанавливаем тит страницы
		Page.setTitle($scope.group.title)

	$scope.$on "$routeChangeStart", ->
		canceler.resolve()
	
]