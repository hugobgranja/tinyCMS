class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to admin_root_url
    end
  end

  def create
    @user = User.find_by_username(params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to admin_root_url
    else
      redirect_to root_url
    end
  end

  def destroy 
    session[:user_id] = nil 
    redirect_to root_url
  end
end
