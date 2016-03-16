app.factory "Group", ["$http", "$q", ($http, $q) ->
	groups = {}

	#Все группы
	groups.list = []

    #Список
	groups.tree = {}

	groups.setGroup = (id) ->
		groups.tree = groups.build_tree(id)

	groups.getList = ->
	  defer = $q.defer()
	  $http.get("api/groups/tree").success((res) ->
	    groups.list = res
	    defer.resolve res
	    return
	  ).error (err, status) ->
	    defer.reject err
	    return
	  defer.promise

	groups.find_group = (id) ->
		i = 0
		while i < groups.list.length
			if id.toString() == groups.list[i].id.toString()
				group = groups.list[i]
			i++
		return group

	groups.build_tree_menu = (id) ->
		if groups.list.length > 1
			group = {}
			group.parent = []
			group.current = groups.find_group(id)
			group.children = groups.build_child(group.current)
			if group.current && group.current.ancestry != null
				array = group.current.ancestry.split("/")
				i = 0
				while i < array.length
					group.parent.push(groups.find_group(array[i]))
					i++
			return group

	groups.build_child = (group) ->
		if group.ancestry == null
			str = group.id.toString(	)
		else
			str = group.ancestry + '/' + group.id
		ar = []
		i = 0
		while i < groups.list.length
			if groups.list[i].ancestry == str
				ar.push(groups.list[i])
			i++
		if ar.length > 0
			group = ar
		group
		
	groups.build_tree = (id) ->
		if groups.list.length > 0
			 groups.tree = groups.build_tree_menu(id)
		else
			groups.getList().then ->
				groups.tree = groups.build_tree_menu(id)
	groups
]
