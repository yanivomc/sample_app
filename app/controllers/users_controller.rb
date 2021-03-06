class UsersController < ApplicationController
  # Checking if a user is signed in
  before_filter :signed_in_user, only: [:edit, :update, :index]
  # Checking if the user that is SIGNED IN is allowed to update,edit a specific profile
  before_filter :correct_user, only: [:edit, :update]
  before_filter :is_admin, only: [:destroy]
  before_filter :signed_in_url_blocked, only: [:new, :create]

  respond_to :html, :xml, :json



  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
    # Configure Content managment (API) request to display users by their email
    @usermail= params[:email]
    @renderesource = User.find_all_by_email  @usermail #using the _all_by_ allowed me to search by other then ID

    respond_to do |format|
      format.xml {render xml:@renderesource}
      format.json {render json:@renderesource}
      format.html {render html:@users}
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash_internal_messages("Your profile was changed - Please re-login")
      redirect_to signin_path
    else
      render 'edit'
    end
  end

  def flash_internal_messages(message)
    flash[notice] = message

  end



  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
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


  def destroy
    User.find(params[:id]).destroy
    flash['success'] = "User was deleted from the DB."
    redirect_to users_url
  end


  # //// Private ////

  private
  def signed_in_url_blocked
    # Redirect signed_in users back to their original location if they try to reach :create or :new

    redirect_to (root_path) unless !signed_in?
  end

  private
  def is_admin
    redirect_to(root_path) unless current_user.admin?

  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)

  end

  def signed_in_user
    # Check if a user is signed in   
    #redirect_to signin_url, notice: "You are not signed in, please sign in." unless signed_in?
    unless signed_in?
      store_location # Store the location of the requested URL 
      redirect_to signin_url, notice: "You are not signed in, please sign in."
    end


  end
end

  




