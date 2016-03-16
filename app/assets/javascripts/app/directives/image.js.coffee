app.directive "itemImage", ->
	restrict: "E"
	transclude: true
	scope: {
		id: "="
		image: "="
		size: "="
	}
	link: (scope, element, attrs) ->
		setUrl = ->
			if scope.size == 'list'
				noimage = 'img_thumb'
				isize = 'thumb'
			if scope.size == 'thumbs'
				noimage = 'img_thumb_m'
				isize = 'thumb_m'
			if scope.size == 'img_item'
				noimage = 'img_item'
				isize = 'item'
			if scope.size == 'img_large'
				noimage = 'img_large'
				isize = 'large'
			if scope.image == 't'
				return url = 'uploads/item/'+scope.id%20+'/'+isize + '_'+md5(scope.id+''+isize)+'.jpg'
			else
				return noimage

		setImage = ->
			if scope.image == "t"
				html = "<img src="+setUrl()+"></img>"
			else
				html = "<div class="+setUrl()+"></div>"
			element.html html

		watch_img = scope.$watch (->
			scope.image), ((newVal,oldVal) ->
				if scope.image
					setImage()
					watch_img()
				)
		watch_size = scope.$watch (->
			scope.size), ((newVal,oldVal) ->
				if scope.image
					setImage()
				)

app.directive "currency", ["User", (User) ->
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
				price = scope.value * (100-User.discount) / 100
				element.html accounting.formatMoney(price, "", 2, " ", ",")

		scope.$watch (->
			User.discount), ((newVal,oldVal) ->
				setTimeout( ->
					setPrice()
				, 100)
				)

		watch = scope.$watch (->
			scope.value), ((newVal,oldVal) ->
				setTimeout( ->
					setPrice()
				, 100)
				)
]

app.directive "labeltext",  ->
	restrict: "E"
	scope:	{
		variant: "="
	}
	link: (scope, element, attrs) ->
		if scope.variant is "special"
			text = "акция"
		if scope.variant is "hit"
			text = "популярный"
		if scope.variant is "new"
			text = "new"
		element.html text

