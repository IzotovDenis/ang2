app.directive "goFind", ["$location", "$document", ($location, $document) ->
  restrict: "A"
  link: ($scope, elem, attrs) ->  
    elem.bind "click", ->
    	$location.url('find?query=' + attrs.goFind)
    	$scope.$apply()
]


app.directive "itemoem", ->
	restrict: "E"
	replace: true
	template: "<div class='oems'></div>"
	scope: {
		oems: "="
	}
	link: (scope, element, attrs) ->
		render = ->
			if scope.oems
				html = "<span class='oems-label'>OEM:</span>"
				oem = scope.oems.split(/,|;/)
				i = 0
				while i < oem.length
					html += "<span class='oem cursor-pointer' title='Искать товары с ОЕМ: "+oem[i].trim()+"'><a href='find?query="+ oem[i].trim()+"'>"+oem[i].trim()+"</a></span>"
					i++
			element.html html
		setTimeout(render,100)