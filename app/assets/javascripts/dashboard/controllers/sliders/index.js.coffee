dashboard.controller "SlidersIndexCtrl", SlidersIndexCtrl = ["$scope", "$http", "$location", ($scope, $http, $location) ->

	$scope.newSlider = {}


	loadSliders = ->
		$http.get("/dashboard/api/sliders").success (data) ->
			$scope.sliders = data

	loadSliders()

	$scope.$watch "image.base64", (newValue, oldValue) ->
		if newValue isnt oldValue
			img = "data:"+$scope.image.filetype+";base64,"+$scope.image.base64
			$scope.newSlider.image = img

	$scope.removeSlider = (id) ->
		$http.delete("/dashboard/api/sliders/" + id).success (data) ->
			loadSliders()

	$scope.createSlider = ->
		$http.post("/dashboard/api/sliders", slider: $scope.newSlider).success (data) ->
			$scope.newSlider = {}
			loadSliders()
]