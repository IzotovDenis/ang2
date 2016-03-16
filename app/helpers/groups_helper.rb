module GroupsHelper

	#Сортировка товаров во всех группах
	def order_all
		Group.able.all.each do |group|
			sort_group(group.id)
		end
	end

	# Сортировка товара в группе с сохранением
	def sort_group(group_id)
		@items = Item.where(:group_id=>group_id).able.includes(:prices).sort_by &:full_title
			@items.each_with_index do |item, index|
				item.update_attribute("position", index+1)
			end
	end

	def group_column(group)
		count = tree_count(group).count
		case count
			when 0..19
				return "1"
			when 20..60
				return "2"
			else
				return "3"
		end
	end

	def tree_count(tree, p = 0)
	  id = tree["id"]
	  (tree["children"] || [])
	    .flat_map { |sub| tree_count(sub, id) }
	    .unshift("id" => id, "parent_id" => p)
	end

end
