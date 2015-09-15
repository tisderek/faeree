module MainHelper

  def user
    @user ||= User.find_by(token: cookies[:token])
    # User.find(1)
  end	

	def username
	  user.name
	end

	def signup
		#RF BCrypt version
	  # @user = User.new(
	  #   name: params[:name],
	  #   phone: just_nums(params[:phone]),
	  #   email: params[:email]
	  #   )
	  # @user.password = params[:password]
	  @user = User.new(
	    name: params[:name],
	    phone: just_nums(params[:phone]),
	    email: params[:email]
	    )
	  @user.password = params[:password]
	end
  
	def login
	  user_to_login = User.find_by(
	    phone: just_nums(params[:phone])
	  )
	  # BCrypt version
	  # if user_to_login.password == params[:password]
	  if user_to_login.password == params[:password]
	    user_to_login.generate_token
	    cookies[:token] = user_to_login.token
	  end
	end

	def logged_in?
    !!cookies[:token] && user
  end

	def logout
	  cookies[:token] = nil
	end

	def display_phone(num)
		num.insert(0,"(").insert(4,") ").insert(-5,"-")
	end

	def user_authorized?
	  params[:id] == user.id
	end

	def cookies_error
	  {
	   signup: "Either you already have an account or your password is too short!"
	  }
	end

	def just_nums(phone)
	  phone.gsub(/[^\d]/, "")
	end

end
