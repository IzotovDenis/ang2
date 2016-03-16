# Фабрика для баннеров
app.factory "Banner", [ ->
	banner = this
	banner.list = {}
	banner.list.slot = []
	banner.list.carousel = []
	banner.list.well = []

	banner.setBanners = (data) ->
		if data.slot
			banner.list.slot = shuffleArray(data.slot)
		if data.well
			banner.list.well = data.well
		if data.carousel
			banner.list.carousel = shuffleArray(data.carousel)

	banner.getBanners = ->
		banner.list

	shuffleArray = (array) ->
		m = array.length
		t = undefined
		i = undefined
		# While there remain elements to shuffle
		while m
			# Pick a remaining element…
			i = Math.floor(Math.random() * m--)
			# And swap it with the current element.
			t = array[m]
			array[m] = array[i]
			array[i] = t
		array

	banner
]