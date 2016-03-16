dashboard.controller "PostsIndexCtrl", PostsIndexCtrl = ["$scope", "$http", "$location", "$filter", ($scope, $http, $location, $filter) ->
	$scope.posts = []
	getPosts = ->
		$http.get("/dashboard/api/posts").success (data) ->
			$scope.posts = data.company_block

	getPosts()

	$scope.deletePost = (id) ->
		$http.delete("/dashboard/api/posts/" + id).success (data) ->
			if data.success == true
				getPosts()

	startSort = ->
		array = []
		angular.forEach($scope.posts, (post) ->
			array.push(post['id']))
		return array

	$scope.saveSort = ->
		$http.post("/dashboard/api/posts/sort", posts: startSort()).success (data) ->
			console.log(data)
		console.log(startSort()) 

]