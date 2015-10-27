class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to movies_path
    else 
      render :new #render an action's view
    end
  end

  protected
  def user_params
    params.require(:user).permit(:email, :firstname,:lastname,:password, :password_confirmation)
  end
end