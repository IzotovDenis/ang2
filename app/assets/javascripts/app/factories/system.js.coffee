app.factory "System", ->
	system = {}
	system.group = {}
	system.error = {status: false}
	system.OnlyInStock = false

	system.toggleInStock = ->
		system.OnlyInStock = !system.OnlyInStock
		console.log("toggle")

	return system
