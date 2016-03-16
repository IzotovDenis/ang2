json.id item.id
json.title item.properties["Полное наименование"]
json.kod item.properties["Код товара"]
json.article item.article
json.image do 
	json.exist item.image?
	json.img_thumb item.image.thumb.url
	json.img_item item.image.item.url
	json.img_large item.image.large.url
end
