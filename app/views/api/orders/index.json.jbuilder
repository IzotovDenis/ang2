json.array! @orders do |order|
	json.id order.id
	json.total order.total
	json.date Russian::strftime(order.formed, "%d %B %Y %H:%M")
	json.comment order.comment
end