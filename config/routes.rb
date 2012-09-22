DataEngineering::Application.routes.draw do

  get  '/uploads' => 'uploads#index', :as => 'uploads'
  get  '/uploads/:id' => 'uploads#view_upload', :as => 'view_upload'
  post '/uploads' => 'uploads#process_upload'

  # for OpenID authentication
  resource :session

end
