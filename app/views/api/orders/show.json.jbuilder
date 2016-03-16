json.id @order.id
json.amount @order.amount
json.comment @order.comment
json.formed Russian::strftime(@order.formed, "%d %B %Y %H:%M")
json.items @order_items do |order_item|
	json.partial! "api/orders/order_item.json", order_item: order_item
end