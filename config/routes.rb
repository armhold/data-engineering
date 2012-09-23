DataEngineering::Application.routes.draw do

  root :to => 'home#index'

  resources :uploads

  # for OpenID authentication
  resource :session

end
