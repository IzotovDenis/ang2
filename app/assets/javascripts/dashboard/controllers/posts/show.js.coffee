dashboard.controller "PostsShowCtrl", PostsShowCtrl = ["$scope", "$http", "$location", "$routeParams", ($scope, $http, $location, $routeParams) ->
	$scope.post = {}

	if $routeParams.postId == "new"
		$scope.post = {}
	else
		$http.get("/dashboard/api/posts/" + $routeParams.postId).success (data) ->
			$scope.post = data

	$scope.savePost = ->
		if $scope.post.id
			$http.put("/dashboard/api/posts/" + $scope.post.id, post: $scope.post).success (data) ->
				$location.url("/posts/")
		else
			$http.post("/dashboard/api/posts/", post: $scope.post).success (data) ->
				$location.url("/posts/")

]