json.id order.id
json.user do
	json.id order.user_id
	json.name order.user.name
end
json.comment order.comment
json.amount number_with_precision(order.total, precision: 2)
json.date Russian::strftime(order.formed, "%H:%M %d %B %Y") if order.formed?