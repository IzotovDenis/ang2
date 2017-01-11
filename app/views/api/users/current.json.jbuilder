json.id @user.id
json.name @user.name
json.role @user.role
json.token form_authenticity_token
if can? :create, OrderItem
json.can_order true
else
json.can_order false
end
if can? :set, :discount
json.can_set_discount true
else
json.can_set_discount false
end