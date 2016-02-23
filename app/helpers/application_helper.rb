module ApplicationHelper
	def name_or_email(current_user)
		if current_user.name.nil?
			return current_user.email
		end
		return "Hi, #{current_user.name}"
	end
end
