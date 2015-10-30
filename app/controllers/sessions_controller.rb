class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email:params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin == "t" 
        redirect_to movies_path, notice: "Log in as admin"
      else 
        redirect_to movies_path, notice: "welcome back, #{user.firstname}"
      end
    else
      flash.now[:alert] = "Log in failed.."
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Adios!"
  end
end
