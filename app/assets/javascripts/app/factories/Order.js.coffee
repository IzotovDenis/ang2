app.factory "Order", ["$http", "$q", "$filter", ($http, $q, $filter) ->
	order = this
	order.current = {}
	order.current.items = []
	order.current.amount = 0
	order.loading = false
	order.empty = false
	order.itemList = []
	order.busy = false

	order.checkOrder = ->
		if order.current.items.length > 1
			order.empty = true
		else 
			order.empty = false

	order.itemIds = []

	order.getCurrentIds = ->
		defer = $q.defer()
		$http.get("api/orders/current?type=ids").success((res) ->
			order.setItemIds(res)
			defer.resolve res
			return
		).error (err, status) ->
			defer.reject err
			return
		defer.promise

	order.getCurrent = ->
		defer = $q.defer()
		$http.get("api/orders/current").success((res) ->
			order.current = res
			defer.resolve res
			order.calcAmount()
			order.checkOrder()
			return
		).error (err, status) ->
			defer.reject err
			return
		defer.promise

	order.calcAmount = ->
		order.current.amount = 0
		i = 0
		while i < order.current.items.length
			order.current.amount += order.current.items[i].ordered*order.current.items[i].price
			i++
		console.log(order.current)

	order.itemAdd = (item) ->
		items = {}
		items[item.id] = item.ordered || "1"
		order.AddToCart(items)

	order.itemsAdd = (items_list) ->
		i = 0
		items = {}
		while i < items_list.length
			items[items_list[i].id] = items_list[i].ordered || "1"
			i++
		order.AddToCart(items)



	order.AddToCart = (items) ->
		console.log("click")
		defer = $q.defer()
		$http.post('api/orders/add_items', {'items':items}).success((res) ->
			order.setItemIds(res.items)
			order.calcAmount()
			defer.resolve res
		).error (err, status) ->
			defer.reject(err)
		defer.promise

	order.setItemIds = (items) ->
		order.itemIds = []
		console.log(Object.keys(items).length)
		for key of items
			item = {}
			item['item_id'] = key
			item['qty'] = items[key]['qty']
			order.itemIds.push(item)
		console.log(order.itemIds)

	order.deleteFromCart = (items) ->
		if order.busy
			console.log("busy")
		unless order.busy
			ids = []
			i = 0
			while i < items.length
				ids.push(items[i]['id'])
				i++		
			console.log(ids)
			order.busy = true
			$http.post("api/orders/delete_items", items: ids).success((data) ->
				i = 0
				while i < items.length
					console.log(items[i])
					order.current.items.splice(order.current.items.indexOf(items[i]), 1)
					i++
				order.setItemIds(data.items)					
				order.calcAmount()
				order.busy = false)
				.error (err, status) ->
					order.busy = false
	order
]