class MainController < ApplicationController
  def session_destroy
  end

  def session_create
  	login
  end

	def index
		if logged_in?
			render 'dashboard'
		else
			# render 'splash'
			render 'dashboard'
		end
	end

	def logged_in?
    !!cookies[:token] && user
  end	
end
