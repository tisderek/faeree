module UsersHelper

	def display_phone(num)
		num.insert(0,"(").insert(4,") ").insert(-5,"-")
	end

	def user
	  @user ||= User.find_by(token: cookies[:token])
	  User.find(1)
	end

	def username
	  user.name
	end

end
