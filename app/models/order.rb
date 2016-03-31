class Order < ActiveRecord::Base
	belongs_to :user
	has_many :order_items, dependent: :destroy
	has_many :items, :through => :order_items
	accepts_nested_attributes_for :order_items
	scope :ready, ->{includes(:order_items, :user, :items=>:prices).where("formed IS NOT NULL").order("formed DESC")}
	scope :period, ->(period) {ready.where(:formed=>period)}
	scope :today, ->{where(:formed=>DateTime.now.beginning_of_day..DateTime.now.end_of_day).ready}
	scope :formed_from, ->(period) {where(["formed >= ?", period]).ready}
	scope :formed_before, ->(period) {where(["formed <= ?", period]).ready}
	self.per_page = 30

	after_save :update_orders_counter_cache
	after_destroy :update_orders_counter_cache

	def update_orders_counter_cache
		if self.formed
			user = User.where(:id => self.user_id).first
			if user
				user.update_attribute('orders_count', Order.where(:user_id=>user.id).count)
			end
		end
	end

	def complete
		self.formed = Time.now if !self.formed
		@items = Order.show_list(self.id)['items']
		total = 0
			@items.each do |item|
				self.order_list[item['id']]['price'] = item['price'].to_f
				total += item['price'].to_f.round(2) * item['ordered'].to_i
			end
		self.total = total
		self.save!
	end

	def amount
		@total = 0
		self.order_items.includes(:item=>:prices).each do |order_item|
			@total += order_item.qty*order_item.item.price
		end
		@total
	end 

	def count_position
		self.order_items.count
	end

	def good?
		self.order_list.keys.count >=1
	end

	def self.pg_result
		connection = ActiveRecord::Base.connection
		connection.execute(joins("LEFT JOIN currencies ON currencies.name = (items.bids->'0fa9bc88-166f-11e0-9aa1-001e68eacf93'->>'cy')")
				.joins(:order_items=>:item)
				.select("
						items.article,
						items.full_title as title,
						items.id,
						items.properties-> 'Код товара' as kod,
						order_items.qty as qty,
						order_items.id as order_item_id,
						CASE  WHEN items.qty BETWEEN 0 AND 9 THEN items.qty::text
									WHEN items.qty BETWEEN 10 AND 49 THEN '10-49'::text
									WHEN items.qty BETWEEN 50 AND 100 THEN '50-100'::text
									ELSE '> 100'::text END as item_qty,
						CASE coalesce(items.image, 'null') WHEN 'null' THEN 'false'::boolean ELSE 'true' END AS image,
				coalesce((items.bids->'0fa9bc88-166f-11e0-9aa1-001e68eacf93'->>'value')::float*currencies.actual, '0.00') as price").to_sql)
	end


	def self.show_list(id)
		@order = Order.where(:id=>id).select("id, formed, total, comment, user_id").first
		if @order
		@price_type = @order.user.price_type
		connection = ActiveRecord::Base.connection
			hash = {}
			hash['id'] = @order.id
			hash['amount'] = @order.total
			hash['date'] = Russian::strftime(@order.formed, "%H:%M %d %B %Y") if @order.formed
			hash['comment'] = @order.comment
			hash['items'] = connection.execute("SELECT
						items.article,
						json_data.key AS id, 
						json_data.value::jsonb->'qty' AS ordered,
						round (CAST (CASE coalesce(orders.formed::text, 'null') WHEN 'null' THEN coalesce((coalesce((items.label->'discount')::float*(items.bids->'#{@price_type}'->>'value')::float, (items.bids->'#{@price_type}'->>'value')::float))*currencies.actual, '0.00')::text ELSE CAST(json_data.value::jsonb->'price' AS text) END AS numeric),2) AS price,
						items.full_title as title,
						CASE  WHEN items.qty BETWEEN 0 AND 9 THEN items.qty::text
									WHEN items.qty BETWEEN 10 AND 49 THEN '10-49'::text
									WHEN items.qty BETWEEN 50 AND 100 THEN '50-100'::text
									ELSE '> 100'::text END as item_qty,
						CASE coalesce(items.image, 'null') WHEN 'null' THEN 'false'::boolean ELSE 'true' END AS image,
						items.properties-> 'Код товара' as kod
						FROM orders, jsonb_each_text(orders.order_list) AS json_data
						INNER JOIN items ON items.id = json_data.key::int
						LEFT JOIN currencies ON currencies.name = (items.bids->'#{@price_type}'->>'cy')
						WHERE orders.id=#{id}")
		else
			hash = {}
			hash['id'] = ''
			hash['amount'] = 0
		end
		hash
	end



end


