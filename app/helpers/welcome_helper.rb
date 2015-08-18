module WelcomeHelper
	 def logged_in?
    !!cookies[:token] && user
  end

  def user
    @user ||= User.find_by(token: cookies[:token])
    # User.find(1)
  end
end
