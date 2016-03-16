app.directive "denismenu", [ "$timeout", "RightMenu", ($timeout, RightMenu)  ->
	restrict: "A"
	link: ($scope, elem, attrs) ->
		elem.bind "click", ->
			RightMenu.active = true
			RightMenu.current = attrs.id
			$scope.aa = RightMenu.current
			$scope.cinTimeout = false
			$scope.$apply()

		elem.bind "mouseover", ->
			if RightMenu.active
				RightMenu.next = attrs.id
				$scope.cinTimeout = false
				$timeout (->
					if RightMenu.next == attrs.id
						RightMenu.next = false
						$scope.aa = attrs.id
						$scope.$apply()
					return
				), 500

		elem.bind "mouseleave", ->
			RightMenu.next = false
			$scope.$apply()
			$timeout (->
				if $scope.cinTimeout == true
					$scope.cinTimeout = false
					$scope.inTimeout = false
					$scope.aa = false
					$scope.$apply()
					RightMenu.active = false
				return
			), 500
			$scope.cinTimeout = true
]

app.directive "denismenu1", [ "$timeout", "RightMenu", ($timeout, RightMenu)  ->
	restrict: "A"
	link: ($scope, elem, attrs) ->  

		elem.bind "mouseover", ->
			$scope.inTimeout = false
			$scope.cinTimeout = false
			$scope.aa = attrs.id
			$scope.cinTimeout = false
			$scope.$apply()

		elem.bind "mouseleave", ->
			$timeout (->
				if $scope.cinTimeout == true
					$scope.cinTimeout = false
					$scope.aa = false
					RightMenu.active = false
					$scope.$apply()
				return
			), 500
			$scope.cinTimeout = true
]
