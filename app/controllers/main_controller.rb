class MainController < ApplicationController
	include MainHelper
	
  def session_destroy
  end

  def session_create
  	login
  end

	def home
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
