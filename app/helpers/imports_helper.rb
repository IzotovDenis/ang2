module ImportsHelper
	def set_cookie
		Digest::SHA512.hexdigest(Time.now.to_s)
	end
end
