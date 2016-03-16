json.id @offer.id
json.text @offer.store['text'] if @offer.store
json.title @offer.title
json.items @items do |item|
	json.partial! "api/items/item.json", item: item
end