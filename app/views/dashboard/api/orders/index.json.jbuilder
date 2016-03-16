json.array! @orders.each do |order|
	json.partial! order
end