module OrdersHelper
	

def current_order
  Order.find_or_initialize_by(:user=>current_user,:formed=>nil)
end

end
