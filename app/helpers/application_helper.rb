module ApplicationHelper
include OrdersHelper

def resource_name
:user
end

def helper_item_qty(qty)
	a = qty.to_s if qty < 10
	a = "10-49" if qty > 9 && qty < 50
	a = "50-100" if qty > 49 && qty < 101
	a = "> 100" if qty > 100
	a
end

def resource
@resource ||= User.new
end

def devise_mapping
	@devise_mapping ||= Devise.mappings[:user]
end

def price(value)
	number_with_precision(value, precision: 2) 
end

def cy_value(currency_name)
	if @currency = Currency.where(:name=>currency_name).first
		@currency.actual
	else
		0
	end
end

def page_title(page_title)
content_for :title, "#{page_title.to_s} | #{t(:title)}"
end

def groups
Group.all.arrange_serializable(:order=>:position)
end

def find_attributes
[[ "Везде","anywhere"],
[ "Код товара","code"],
[ "Артикул","article"],
[ "Наименование","title"],
[ "ОЕМ","OEM"]]
end

def user_roles(role = false)
@roles = {'user'=>'Пользователь','buyer'=>'Покупатель','superbuyer'=>'Супер покупатель','admin'=>'Администратор','dev'=>'Джедай'}
@avaiable = {'user'=>'Пользователь','buyer'=>'Покупатель','superbuyer'=>'Супер покупатель'}
if role
@roles[role] ? @roles[role] : role
else 
@avaiable
end
end


end
