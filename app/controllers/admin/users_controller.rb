class Admin::UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page]).per(3)
  end

  def new
  end

  def show
    @user = User.find(params[:id])   
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to edit_admin_user_path(@user), notice: "User profile has been updated!"
    else
      render :edit 
    end
  end

  protected 
  def user_params
    params.require(:user).permit(:email,:lastname,:firstname)
  end
end
