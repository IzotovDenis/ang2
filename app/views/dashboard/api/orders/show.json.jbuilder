if @order
	json.partial! "dashboard/api/orders/order", order: @order
	json.items @order.order_items.each do |order_item|
		json.id order_item.item.id
		json.title order_item.item.properties["Полное наименование"]
		json.kod order_item.item.properties["Код товара"]
		json.article order_item.item.article
		json.image do 
			json.exist order_item.item.image?
			json.img_thumb order_item.item.image.thumb.url
			json.img_item order_item.item.image.item.url
			json.img_large order_item.item.image.large.url
		end
		json.price price(order_item.item.price)
		json.item_qty helper_item_qty(order_item.item.qty)
		json.qty order_item.qty
		json.order_item_id order_item.id
	end
end