app.factory "User", ["$http", "$q", ($http, $q) ->
	user = this
	user.authorized = false
	user.can_order = false
	user.discount = 0

	user.setDiscount = (value) ->
		user.discount = value

	user.set = (data) ->
		user.authorized = true
		user.login = data.name
		user.id = data.id
		user.can_order = data.can_order

	user.getCurrent = ->
	  defer = $q.defer()
	  $http.get("api/users/current?r="+Math.random()).success((res) ->
	    user.set(res)
	    defer.resolve res
	    return
	  ).error (err, status) ->
	    defer.reject err
	    user.authorized = false
	    return
	  defer.promise

	user
]