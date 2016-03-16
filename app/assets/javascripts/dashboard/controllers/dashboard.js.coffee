dashboard.controller "MainCtrl", MainCtrl = ["$scope", "$http", "$timeout", ($scope, $http, $timeout) ->

	countUp = ->
		$http.get('/dashboard/api/stat').success (data) ->
			$scope.stat = data

	countUp()

	loadCurrencies = ->
		$http.get('/dashboard/api/currencies').success (data) ->
			$scope.currencies = data

	loadCurrencies()

	$scope.addCurrency = ->
		$http.post('/dashboard/api/currencies', currency: $scope.newCurrency).success (data) ->
			loadCurrencies()
			$scope.newValForm = false
			$scope.newCurrency = {}

	$scope.currencyDisabled = {}
	$scope.currencyDeleted = {}

	$scope.setEnabled = (currency) ->
		$scope.currencyDisabled[currency.id] = true

	$scope.isEnabled = (currency) ->
		$scope.currencyDisabled[currency.id]

	$scope.setRate = (currency, index) ->
		$http.post("/dashboard/api/rates", {rate: {value: currency.value}, currency_id: currency.id}).success (data) ->
			$scope.currencies[index] = data
			$scope.currencyDisabled[currency.id] = false

	$scope.currencyDelete = (deleteCurrencyName, currency, index) ->
		if deleteCurrencyName == currency.name
				$http.delete("/dashboard/api/currencies/"+currency.id).success (data) ->
					console.log(data)
					$scope.currencies.splice(index, 1)
		else
			console.log("none")

	$scope.newPricelist = ->
		$http.post("/dashboard/api/pricelists").success (data) ->
			$scope.pricelist = data
]