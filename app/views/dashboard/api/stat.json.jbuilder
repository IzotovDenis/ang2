json.activities @activities do |activity|
	json.partial! "dashboard/api/activities/activity", activity: activity
end
json.online @online do |user|
	json.partial! "dashboard/api/users/user", user: user
end
json.noobs @noobs do |user|
	json.partial! "dashboard/api/users/user", user: user
end
json.orders @orders do |order|
	json.partial! "dashboard/api/orders/order", order: order
end
