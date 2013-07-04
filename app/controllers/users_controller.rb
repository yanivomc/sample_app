class UsersController < ApplicationController
  def show
    
    @user_validate = User.find(params[:id])
    if cookies[:remember_token] == @user_validate.remember_token then
    @user = User.find(params[:id])
    else
      flash[:success] = "You required to login"
      redirect_to signin_path
    end
    
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
           flash[:success] = "Welcome to MyMaid!"
           sign_in @user
            redirect_to @user

    else
      render 'new'
    end
  

  
  end
end


