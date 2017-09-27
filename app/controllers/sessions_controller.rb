class SessionsController < ApplicationController

  def new
  end



  def create
    #find user in database by email
    user = User.find_by(email: params[:session][:email].downcase)
    #if user is in database and if the authenticate(automatic AR method) method returns true
    if user && user.authenticate(params[:session][:password])
      #this is a method sitting in the sessions_helper it sets the session hash to the users id
      log_in(user)
      redirect_to user #same as redirect_to user_url(user) thru rails magic
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
