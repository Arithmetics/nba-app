class UsersController < ApplicationController

  #this is the users/new page controller the @user variable is passed to the view
  #the User is created using the User class defined in the model
  def new
    @user = User.new
  end

  #this is the controller for the GET request to a users page
  def show
    #the params[:id] is served by the url request
    @user = User.find(user_params)
  end

  #uses what is POSTed from a user creation form
  def create
    @user = User.new(params[:user])
    if @user.save
      #do a dave
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
