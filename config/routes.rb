DataEngineering::Application.routes.draw do

  root :to => 'home#index'

  resources :uploads, :only => [:index, :new, :show, :create]

  # for OpenID authentication
  resource :session

end
