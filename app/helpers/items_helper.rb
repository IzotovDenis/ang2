module ItemsHelper

	def item_specs(item)
		item.properties.slice('Код товара', 'Страна изготовитель', 'Количество в упаковке', 'Вес', 'ОЕМ')
	end
end
