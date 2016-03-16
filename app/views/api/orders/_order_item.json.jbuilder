json.id order_item.item.id
json.title order_item.item.properties["Полное наименование"]
json.kod order_item.item.properties["Код товара"]
json.article order_item.item.article
if order_item.item.image?
json.image "t"
else
json.image "f"
end
json.price price(order_item.item.price)
json.item_qty helper_item_qty(order_item.item.qty)
json.qty order_item.qty
json.order_item_id order_item.id