json.id @order.id
json.items @order_items do |order_item|
	json.partial! "api/orders/order_item.json", order_item: order_item
end
json.items_count @order.order_items.count
json.amount price(@order.amount)