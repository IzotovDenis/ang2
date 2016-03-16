json.status @status
json.errors @user.errors.values.flatten!
json.user do
	json.partial! "api/users/user.json"
end