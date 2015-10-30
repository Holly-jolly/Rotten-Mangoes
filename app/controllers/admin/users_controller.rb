class Admin::UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page]).per(3)
  end

  def new
    @user= User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_admin_user_path,notice: "A new user is added"
    else 
      render :new #render an action's view
    end
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

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path(@user), notice: "User ID #{@user.id} has been deleted"
    end
  end

  protected 
  def user_params
    params.require(:user).permit(:email,:lastname,:firstname, :password,:password_confirmation)
  end
end
