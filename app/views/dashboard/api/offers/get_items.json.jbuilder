json.array! @items.each do |item|
	json.partial! "dashboard/api/offers/item", item: item
end