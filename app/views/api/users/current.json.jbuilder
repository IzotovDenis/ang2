json.id @user.id
json.name @user.name
json.role @user.role
json.token form_authenticity_token
if can? :view_price, Item
json.can_order true
else
json.can_order false
end