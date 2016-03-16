dashboard.controller "FilesIndexCtrl", FilesIndexCtrl = ["$scope", "$http", "$location","$modal", "$upload", "FileManager", ($scope, $http, $location, $modal, $upload, FileManager) ->

	$scope.fm = FileManager
	$scope.work = "well"

	$scope.newFolder = ->
		modalInstance = $modal.open(
			templateUrl: "dashboard/templates/files/new_folder.html"
			controller: "ModalNewFolderCtrl"
			windowClass: 'modal-order'
		)

		modalInstance.result.then ((newFolder) ->
			FileManager.createFolder(newFolder)
		), ->
			console.log ('Modal dismissed at: ' + new Date)

	$scope.showSelected = (node) ->
		$scope.fm.selectFolder(node)
		$http.get("/dashboard/api/folders/"+node.id).success (data) ->
			$scope.files = data
			console.log(data)

	$scope.upload_image = (files) ->
		if files and files.length
			i = 0
			while i < files.length
				file = files[i]
				$upload.upload(
					url: '/dashboard/api/files/'
					fields: {
						'folder_id': $scope.fm.currentFolder.id
							 }
					file: file).progress((evt) ->
					progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
					console.log 'progress: ' + progressPercentage + '% ' + evt.config.file.name
					return
				).success (data, status, headers, config) ->
					$scope.files.push(data)
				i++

	$scope.$watch 'image_files', ->
		$scope.upload_image $scope.image_files
]