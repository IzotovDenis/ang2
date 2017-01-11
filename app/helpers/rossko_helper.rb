module RosskoHelper

def get_connect
	Savon::Client.new(wsdl: 'http://vl.rossko.ru/service/v1/GetSearch?wsdl', convert_request_keys_to: :camelcase)
end

def j_rossco_query(query)
	client = get_connect
	response = client.call(:get_search, message: { KEY1: 'fddc3def89302f8023319392a629cb0e', KEY2: '95713a23d94f8b5c9f5043e1350619ad', TEXT: query })
	response.body[:get_search_response][:search_results][:search_result]
end

def rossco_query(query)
	client = get_connect
	response = client.call(:get_search, message: { KEY1: 'fddc3def89302f8023319392a629cb0e', KEY2: '95713a23d94f8b5c9f5043e1350619ad', TEXT: query })
	response
end

def rossco_response_to_list(response)
	if response.body[:get_search_response][:search_results][:search_result][:success] 
		parts = response.body[:get_search_response][:search_results][:search_result][:parts_list][:part]
		list = prepare_array(parts)
		return list
	else
		return false
	end
end

def prepare_array(var)
	list = []
	if var.class.to_s == "Hash"
		list.push(var)
	elsif var.class.to_s == "Array"
		list = var
	end
	list
end

def rossco_list_to_offers(list)
	items = []
	if list
		list.each do |item|
			offer_item = item.slice(:guid, :brand, :part_number, :name)
			if item[:stocks_list]
				offer_item[:offers] = []
				puts item[:stocks_list][:stock]
				stocks = prepare_array(item[:stocks_list][:stock]).sort_by { |hsh| hsh[:delivery_time].to_i }
				stocks.each do |i|
					i[:retail_price] = (i[:price].to_f*1.3).round(2)
					offer_item[:offers].push(i)
				end
			end
			items.push(offer_item)
		end
	end
	items
end

def rossco_requerst(query)
	# Ответом будет хеш
	ans = {}
	# отправляем запрос и получаем ответ
	response = rossco_query(query)
	# получаем массив товаров из ответа
	list = rossco_response_to_list(response)
	ans[:success] = (list ? true : false)
	# из массива товаров Росско в список товаров Планета-Авто
	ans[:list] = rossco_list_to_offers(list)
	# Кроссы
	if has_crosses?(list)
		ans[:crosses] = give_me_crosses(list)
	else
		ans[:crosses] = false
	end
	ans
end

def has_crosses?(list)
	if list && list.count == 1
		true if list[0].key?(:crosses_list)
	else
		false
	end
end

def give_me_crosses(list)
	crosses = prepare_array(list[0][:crosses_list][:part])
	resp = rossco_list_to_offers(crosses).sort_by { |hsh| hsh[:brand] }
	resp
end


end
