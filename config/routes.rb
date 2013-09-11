BitlyUpdater::Application.routes.draw do
  get "session/new"

  get "/callback" => "session#callback"


  get "session/destroy"

  put "/user/:id" => "home#add_email", :as => "user"

  root :to => 'home#index'

end
