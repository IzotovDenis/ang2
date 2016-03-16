module OffersHelper

	def set_offer_items(variant, offer_id, item_ids)
		items = Item.where("properties -> 'Код товара' IN (?)", item_ids)
		items.each do |item|
			item.label = {} unless item.label
			item.label[variant] = offer_id.to_s
			item.label_will_change!
			item.save
		end 
	end

	def destroy_offer_items(variant, offer_id)
		items = Item.where("label -> :variant = :value",:variant=>variant, :value=>offer_id.to_s)
		items.each do |item|
			item.destroy_key!(:label, variant)
			item.label_will_change!
			item.save
		end
	end
end

