app.controller "FindCtrl", GroupCtrl = ["$scope", "$http", "$location","Item", "$routeParams", "$modal", "Page", ($scope, $http, $location, Item, $routeParams, $modal, Page) ->

	$scope.find_success = true
	# Устанавливаем урл для запроса, необходим для infinity-scroll
	$scope.error = false	

	# Отправляем запрос на поиск
	sendRequest = ->
		Item.list = []
		Item.busy = true
		url = "/api" + $location.url()
		if Item.list.length < 0
			Item.itemsControl = false
		$http.get(url).success((data) ->
			if data.items.length > 0
				$scope.total_count = data.total_count
				Item.busy = true
				$scope.find_success = true
				# Добавляем первые товары в фабрику
				Item.firstLoad(data.items, url, data.total_entries)
				Item.itemsControl = true
			else
				Item.list = []
				Item.busy = false
				Item.end = true
				$scope.find_success = false
				Item.itemsControl = false
			).error((data, status) ->
				if status == 0
					console.log("Пропало соединение")
				if status == 500
					console.log("Ошибка")
				Item.itemsControl = false
				Item.list = []
				$scope.error = true
				$scope.find_success = true
				Item.itemsControl = false
			)
	sendRequest()

	# Устанавливаем h1 страницы
	$scope.title = "Результат поиска " + $routeParams.query
	# Устанавливаем титл страницы
	Page.setTitle("Поиск " + "\"" + $routeParams.query + "\"")
]