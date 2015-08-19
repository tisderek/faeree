	def login
	  user_to_login = User.find_by(
	    phone_number: just_nums(params[:phone_number])
	  )
	  # BCrypt version
	  # if user_to_login.password == params[:password]
	  if user_to_login.password == params[:password]
	    user_to_login.generate_token
	    cookies[:token] = user_to_login.token
	  end
	end

	def signup
		#RF BCrypt version
	  # @user = User.new(
	  #   name: params[:name],
	  #   phone_number: just_nums(params[:phone_number]),
	  #   email: params[:email]
	  #   )
	  # @user.password = params[:password]
	  @user = User.new(
	    name: params[:name],
	    phone_number: just_nums(params[:phone_number]),
	    email: params[:email]
	    )
	  @user.password = params[:password]
	end

	def cookies_error
	  {
	   signup: "Either you already have an account or your password is too short!"
	  }
	end

	def just_nums(phone_number)
	  phone_number.gsub(/[^\d]/, "")
	end

	def logout
	  cookies[:token] = nil
	end



	def user_authorized?
	  params[:id] == user.id
	end



