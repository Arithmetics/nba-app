Rails.application.routes.draw do


  #maps request for URL /static_pages/home to the home action in the controller
  get 'static_pages/home'
  #same thing for other pages
  get 'static_pages/help'
  get 'static_pages/about'

  #sets the root page of the application to go to the application controller
  root 'application#hello'

end
