dashboard.directive "actionlog", ->
	restrict: "E"
	transclude: true
	scope: {
		log: "="
		controller: "="
		action: "="
	}
	link: (scope, element, attrs) ->
		renderFind = ->
			html = "Искал: <b>" + scope.log.text + "</b> Результатов: <b>" + scope.log.result + "</b>"

		renderGroup = ->
			switch (scope.action)
				when "index"
					html = "Зашел на главную"
				when "show"
					html = "Зашел в группу: " + scope.log.group
			html

		renderOrderItem = ->
			switch (scope.action)
				when "create"
					html = "Добавил в корзину: <b>" + scope.log.item_title + "</b> " + scope.log.qty + " шт."
				when "update"
					html = "Изменил кол-во: <b>" + scope.log.item_title + "</b> " + scope.log.qty + " шт."
				when "destroy"
					html = "Удалил из корзины: <b>" + scope.log.item_title + "</b> " + scope.log.qty + " шт."
			html

		switch (scope.controller)
			when "find"
				html = renderFind()
			when "groups"
				html = renderGroup()
			when "order_items"
				html = renderOrderItem()

		element.append html


