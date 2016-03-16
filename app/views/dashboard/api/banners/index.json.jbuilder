json.array! @banners.each do |banner|
	json.partial! banner
end