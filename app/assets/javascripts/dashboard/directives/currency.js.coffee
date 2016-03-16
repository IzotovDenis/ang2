dashboard.directive "currency", [ ->
	restrict: "E"
	scope:	{
		value: "="
		item: "="
	}
	link: (scope, element, attrs) ->
		setPrice = ->
			if scope.value == "0" && scope.item == true
				element.html "по запросу"
			else
				price = scope.value
				element.html accounting.formatMoney(price, "", 2, " ", ",")
		set = scope.$watch (->
			scope.value), ((newVal,oldVal) ->
				setPrice()
				)
		setPrice()
]