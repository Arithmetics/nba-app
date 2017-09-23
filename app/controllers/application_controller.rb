class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #request comes in from the route to the hello action 'application#hello'
  #this renders html text
  def hello
    render html: "hello, world!"
  end


end
