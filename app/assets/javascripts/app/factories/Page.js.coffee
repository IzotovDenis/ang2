# Фабрика для данных страницы
app.factory "Page", [ ->
	page = this

	# Заголовок страницы
	page.title = ""

	# Получить заголовок страницы
	page.getTitle = ->
		page.title

	# Установить стандартный заголовок
	page.setDefaultTitle = ->
		page.title = "Автотовары оптом Планета-Авто"

	# Установить кастомный заголовок
	page.setTitle = (title) ->
		page.title = title + " | Автотовары оптом Планета-Авто"

	page
]