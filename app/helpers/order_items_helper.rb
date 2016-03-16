module OrderItemsHelper

	def in_cart_class(item)
		if order_list(current_order)[item.id]
			"btn-success"
		end
	end

	def order_list(order)
		Hash[order.order_items.map { |f| [f.item_id,:qty=>f.qty,:id=>f.id]}]
	end

	def order_item_qty(item)
		if order_list(current_order)[item.id]
			order_list(current_order)[item.id][:qty]
		else
			''
		end
	end
end
