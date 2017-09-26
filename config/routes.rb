Rails.application.routes.draw do

  get 'users/new'

  #sets the root page of the application to go to the static_pages controller and do the home action
  root 'static_pages#home'

  #format: action(get) the url_path('/signup'), to: the controller(users) # and the action in the controller(new)
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'


  #this adds ALL of the actions (index, show, new, create, etc. ) and
  #some named routes for user URLs. (in terms of a routes, still need the action
  #in the controller
  resources :users



end
