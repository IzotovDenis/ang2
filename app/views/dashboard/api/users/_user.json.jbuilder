json.id user.id
json.name user.name
json.email user.email
json.inn user.inn
json.role user.role
json.phone user.phone
json.legal_address user.legal_address
json.ogrn user.ogrn
json.city user.city
json.actual_address user.actual_address
json.bik user.bik
json.bank_name user.bank_name
json.bik user.bik
json.curr_account user.curr_account
json.corr_account user.corr_account
json.note user.note
json.person user.person
json.kpp user.kpp
json.created_at Russian::strftime(user.created_at, "%H:%M %d %B %Y")
json.orders_count user.orders_count
json.activities_count user.activities_count
if user.last_activity_at
	json.last_activity_at_hum Russian::strftime(user.last_activity_at, "%H:%M %d %B %Y")
	json.last_activity_at_unix user.last_activity_at.to_i
end