class UsersController < ApplicationController
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
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name,:phone_number,:email,:password)
  end
end
