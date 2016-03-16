json.title "Результаты поиска #{@query}"
json.items @items do |item|
	json.partial! "api/items/item.json", item: item
end
json.total_entries @items.total_entries