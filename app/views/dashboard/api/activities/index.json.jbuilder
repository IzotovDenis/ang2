json.activities do
	json.array! @activities do |activity|
		json.partial! "dashboard/api/activities/activity", activity: activity
	end
end
if !@activities.empty?
	json.last_id @activities.first.id
end 