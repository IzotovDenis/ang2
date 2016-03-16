json.brand do
	json.id @brand.id
	json.title @brand.title
end
if @groups
	json.groups @groups.each do |group|
		json.id group.id
		json.title group.title
	end
end
json.items @items do |item|
	json.partial! "api/items/item.json", item: item
end