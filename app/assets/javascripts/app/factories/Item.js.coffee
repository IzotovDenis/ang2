app.factory "Item", Item = ["Order","$filter","$timeout", (Order,$filter, $timeout) ->
	item = {}
	item.page = 1
	item.busy = false
	item.url = ""
	item.fixedView = false
	item.itemsControl = false
	item.itemsPagin = false
	item.totalEntries = 1000
	item.itemsPerPage = 60
	item.userView = 'list'

	item.itemsView = ->
		if item.fixedView
			item.fixedView
		else
			item.userView

	item.setUserView = (val) ->
		item.userView = val

	item.list = []
	item.setItems = (newItems) ->
		item.list = newItems

	showPagin = ->
		if item.totalEntries > item.itemsPerPage
			item.itemsPagin = true

	item.firstLoad = (newItems, url, total_entries) ->
		item.show_pagin = false
		if newItems.length > 0
			item.itemsControl = true
		else
			item.itemsControl = false
		item.totalEntries = total_entries
		item.busy = true
		item.url = url
		item.end = false
		item.busy = false
		showPagin()
		if newItems.length > 8
			count = 8
		else
			count = newItems.length
		i = 0
		while i < count
			item.list.push(newItems[i])
			i++
		item.setOrderQty()
		if newItems.length > 8
			$timeout( -> 
				item.op(newItems)
			, 150)

	item.op = (obj) ->
		i = 8
		while i < obj.length
			item.list.push(obj[i])
			i++
		item.setOrderQty()






	item.setOrderQty = ->
		i = 0
		while i < item.list.length
			if item.list[i]
				found = $filter('getById')(Order.itemIds, item.list[i].id)
				if found
					item.list[i].ordered = found.qty
					item.list[i].orderitem_id = found.id
				else
					delete item.list[i].ordered
					delete item.list[i].orderitem_id
			i++



	item.getItems = ->
		item.list

	return item
]