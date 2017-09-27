class UsersController < ApplicationController

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


  ##################################################################

  private

    #this method is to protect params[:user] from being hijacked by a malicious user hash
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end



end
