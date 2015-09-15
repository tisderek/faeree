module UsersHelper

	def display_phone(num)
		num.insert(0,"(").insert(4,") ").insert(-5,"-")
	end



end
