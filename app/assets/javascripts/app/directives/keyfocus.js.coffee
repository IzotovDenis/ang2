app.directive "keyFocus", ["$document", ($document) ->
	restrict: "A"
	link: (scope, elem, attrs) ->
		elem.bind "keydown", (e) ->
			if e.keyCode is 38
				unless scope.$first
					position = window.pageYOffset
					elem_position =  $(elem[0].previousElementSibling.querySelector(".order-qty")).parent().parent().position().top
					console.log(position)
					console.log(elem_position)
					if position < elem_position+70
						console.log('visible')
					else
						window.scrollTo(0,elem_position+40)
					elem[0].previousElementSibling.querySelector(".order-qty").focus()
				if scope.$first
					console.log elem[0]
					console.log($document[0].querySelector(".find-input").focus())
			else if e.keyCode is 40
				unless scope.$last
					position = window.pageYOffset + window.innerHeight
					elem_position =  $(elem[0].nextElementSibling.querySelector(".order-qty")).parent().parent().position().top
					if position > elem_position+130
						console.log('visible')
					else
						window.scrollTo(0,elem_position-window.innerHeight+130)
					elem[0].nextElementSibling.querySelector(".order-qty").focus()
				else
					position = window.pageYOffset + window.innerHeight
					elem_position =  $(elem[0].querySelector(".order-qty")).parent().parent().position().top
					if position > elem_position+130
						console.log('visible')
					else
						window.scrollTo(0,elem_position-window.innerHeight+200)					  
]

app.directive "findInput", ["$document", ($document) ->
	restrict: "A"
	link: (scope, elem, attrs) ->
		elem.bind "keydown", (e) ->
			if e.keyCode is 40
				if $document[0].querySelector(".order-qty")
					$document[0].querySelector(".order-qty").focus()
]

app.directive "focusMe", [ ->
	restrict: "A"
	link: (scope, elem, attrs) ->
		elem.on "click", (e) ->
			console.log(this)
			elem[0].select()
]

app.directive 'disableAnimation', ["$animate", ($animate) ->
	restrict: 'A'
	link: ($scope, $element, $attrs) ->
		$attrs.$observe 'disableAnimation', (value) ->
			$animate.enabled !value, $element
]