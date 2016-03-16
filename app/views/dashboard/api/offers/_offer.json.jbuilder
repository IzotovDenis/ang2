json.id offer.id
json.title offer.title
json.variant offer.variant
json.text offer.store['text']
json.thumb offer.store['thumb']
if action_name == "show"
	json.items offer.items.each do |item|
		json.partial! "dashboard/api/offers/item", item: item
	end
end