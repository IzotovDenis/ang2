app.controller "ModalImageCtrl", ModalItemCtrl = ["$scope", "$modalInstance", "item", "$http", ($scope, $modalInstance, item, $http) ->
	$scope.item = item
	
	$scope.closeModal = ->
		$modalInstance.close()
		
	$scope.$on "$routeChangeStart", ->
	  $modalInstance.close()
]