class Admin::UsersController < ApplicationController
  def index
    # @users = User.all 
    @users = User.order(:id).page(params[:page]).per(3)
  end

  def new
  end

  def show
    @user = User.find(params[:id])
    
  end
end
