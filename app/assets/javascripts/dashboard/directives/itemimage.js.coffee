dashboard.directive "itemImage", ->
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
				return url = '/uploads/item/'+scope.id%20+'/'+isize + '_'+md5(scope.id+''+isize)+'.jpg'
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
