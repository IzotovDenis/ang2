json.group do
	json.id @group.id
	json.title @group.site_title
end
json.items do
	json.partial! "api/items/item.json", collection: @items, as: :item
end
json.total_entries @items.total_entries
