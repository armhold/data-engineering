DataEngineering::Application.routes.draw do

  root :to => 'home#index'

  get  '/uploads' => 'uploads#index', :as => 'uploads'
  get  '/uploads/:id' => 'uploads#show', :as => 'view_upload'
  post '/uploads' => 'uploads#create'

  # for OpenID authentication
  resource :session

end
