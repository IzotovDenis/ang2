dashboard.controller "ModalNewFolderCtrl", ModalNewFolderCtrl = ["$scope", "$http", "$location","$modal", "$modalInstance", ($scope, $http, $location, $modal, $modalInstance) ->

	$scope.folder = {}

	$scope.closeModal = ->
		$modalInstance.close()

	$scope.ok = ->
		$modalInstance.close($scope.folder)
]