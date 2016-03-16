json.array! @users do |user|
	json.partial! "dashboard/api/users/user", user: user
end