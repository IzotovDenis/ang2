dashboard.controller "ActivitiesIndexCtrl", ActivitiesIndexCtrl = ["$scope", "$http", "$location", "$filter","$interval", ($scope, $http, $location, $filter, $interval) ->
	$scope.loading = true
	$scope.activs = []

	loadActivity = ->
		$http.get("/dashboard/api/activities?from=" + $scope.last_id).success (data) ->
			if data.last_id
				buildTimeline(data.activities)
				$scope.last_id = data.last_id
		loadOnlineUsers()


	loadActivities = ->
		$http.get("/dashboard/api/activities").success (data) ->
			buildTimeline(data.activities)
			$scope.last_id = data.last_id
		loadOnlineUsers()

	loadOnlineUsers = ->
		$http.get("/dashboard/api/activities/user_online").success (data) ->
			$scope.online = data

	$scope.loadActivities = ->
		console.log('start')
		loadActivity()

	buildTimeline = (data) ->
		data = $filter('orderBy')(data, "id")
		angular.forEach(data, (value) ->
			if $scope.activs.length == 0
				addUser($scope.activs, value)
			else
				if $scope.activs[0].id == value.user.id
					addActivity($scope.activs, value)
				else
					addUser($scope.activs, value)
		)


	loadActivities()

	addUser = (array, activity) ->
		array.unshift(activity.user)
		array[0].activities = []
		array[0].activities.unshift(activity)

	addActivity = (array, activity) ->
		array[0].activities.unshift(activity)
]