module SessionsHelper

  #Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end


  #returns current logged in user
  #takes the user id in the session(browser) and sends it to the db to find a
  #user with the same id. only does this if it already hasn't/@current_user isn't empty
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #returns true if user is logged in, false otherwise
  # sees in @current_user variable is full or not
  def logged_in?
    !current_user.nil?
  end




end
