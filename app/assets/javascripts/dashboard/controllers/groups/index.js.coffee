dashboard.controller "GroupsIndexCtrl", GroupsIndexCtrl = ["$scope", "$http", "$location", ($scope, $http, $location) ->

	$http.get("/dashboard/api/groups").success (data) ->
		$scope.groups = data

	$scope.groupToggle = (id) ->
		$scope.toggle_progress = true
		$http.post("/dashboard/api/groups/toggle", id: id).success (data) ->
			$scope.toggle_progress = false
			$scope.groups = data

	$scope.showGroup = (id) ->
		showGroup()

	$scope.sortGroups = ->
		sortGroups()

	$scope.sortItems = (group_id) ->
		sortItems()


]