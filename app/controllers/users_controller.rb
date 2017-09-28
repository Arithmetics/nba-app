class UsersController < ApplicationController
  #this runs an action down in the private section that checks for logged in-ness to edit and update
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  #makes sure user is not sending edits or creates to another users path
  before_action :correct_user, only: [:edit, :update]
  #make sure user is admin before allowing destroy
  before_action :admin_user, only: [:destroy]

  #this is the users/new page controller the @user variable is passed to the view
  #the User is created using the User class defined in the model
  def new
    @user = User.new
  end

  #this is the controller for the GET request to a users page
  def show
    #the params[:id] is served by the url request
    @user = User.find(params[:id])
  end

  #uses what is POSTed from a user creation form
  def create
    #this used to use params[:user] as the variable, but uses the more secure method
    #defined below in the private section (user_params)
    @user = User.new(user_params)
    if @user.save
      log_in @user #sets session id with session helper method
      flash[:success] = "Welcome to the NBA Over / Under Contest!"
      #this is the rails automagick way of sending to user_url(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end 


  ##################################################################

  private

    #this method is to protect params[:user] from being hijacked by a malicious user hash
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      #sessions helper that checks if current_user is empty (session user)
      unless logged_in?
        store_location #stores where the person was trying to go when they were logged out so that they can be sent there after login in
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      #sets @user to the url bar user (id)
      @user = User.find(params[:id])
      #checks to see if this matches the session helper which checks the session and the cookies
      redirect_to(root_url) unless current_user?(@user) #same as: @user == current_user
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end



end
