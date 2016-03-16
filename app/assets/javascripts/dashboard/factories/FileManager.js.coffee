dashboard.factory "FileManager", ["$http", "$q", ($http, $q) ->
	fm = this

	fm.folders = {}

	fm.currentFolder = {name: "Корень"}

	fm.selectFolder = (folder) ->
		fm.currentFolder = folder
		console.log(fm.currentFolder)

	fm.getRootFolders = ->
		defer = $q.defer()
		$http.get("/dashboard/api/folders/").success((res) ->
			fm.folders = res
			defer.resolve res
			return
		).error (err, status) ->
			defer.reject err
			return
		defer.promise

	fm.createFolder = (newFolder) ->
		newFolder.parent_id = fm.currentFolder.id
		$http.post("/dashboard/api/folders/", folder: newFolder).success((res) ->
			fm.getRootFolders())

	fm.getRootFolders()

	fm
]