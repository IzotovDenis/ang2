dashboard.controller "BannersIndexCtrl", BannersIndexCtrl = ["$scope", "$http", "$location", ($scope, $http, $location) ->

	$scope.newSlider = {}
	$scope.formBanner = {}

	$scope.saveBanner = ->
		if $scope.formBanner.id
			updateBanner()
		else
			createBanner()
			
	$scope.setSortLocation = (location) ->
		$scope.sortLocation = location

	$scope.clearBanner = ->
		$scope.formBanner = {}

	$scope.saveSort = ->
		$http.post("/dashboard/api/banners/sort", banners: startSort()).success (data) ->
			console.log(data)

	$scope.editBanner = (banner) ->
		$scope.formBanner = banner

	$scope.destroyBanner = (banner) ->
		$http.delete("/dashboard/api/banners/" + banner.id).success (data) ->
			$scope.banners[banner.location].splice($scope.banners[banner.location].indexOf(banner), 1)

	updateBanner = ->
		$http.patch("/dashboard/api/banners/" + $scope.formBanner.id, banner: $scope.formBanner).success (data) ->
			$scope.formBanner = {}

	createBanner = ->
		$http.post("/dashboard/api/banners", banner: $scope.formBanner).success (data) ->
			$scope.banners[data.location].push(data)
			$scope.formBanner = {}

	startSort = ->
		array = []
		angular.forEach($scope.banners[$scope.sortLocation], (banner) ->
			array.push(banner['id']))
		return array

	loadBanners = ->
		$http.get("/dashboard/api/banners").success (data) ->
			$scope.banners = data

	loadBanners()

]