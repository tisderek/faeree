class UsersController < ApplicationController
  include MainHelper

  def show
  end

  def new
    @user = User.new
  end

  def edit
    
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if user.update(user_params)
      redirect_to options_path
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name,:phone,:email,:password)
  end

end
