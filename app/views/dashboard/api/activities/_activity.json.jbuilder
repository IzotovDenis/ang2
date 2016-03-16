json.id activity.id
json.user do
	json.id activity.user.id
	json.name activity.user.name
end
json.controller activity.controller
json.action activity.action
json.log activity.log
json.date Russian::strftime(activity.updated_at, "%H:%M %d %B %Y")