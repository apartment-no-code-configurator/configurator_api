Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/services/:id", to: "services#get_object"
  get "/services", to: "services#get_list"
  post "/services", to: "services#create"
  patch "/services/:id", to: "services#update"

  get "/mandatory_apps/:id", to: "mandatory_apps#get_object"
  get "/mandatory_apps", to: "mandatory_apps#get_list"
  post "/mandatory_apps", to: "mandatory_apps#create"
  patch "/mandatory_apps/:id", to: "mandatory_apps#update"

  get "/features/:id", to: "features#get_object"
  get "/features", to: "features#get_list"
  post "/features", to: "features#create"
  patch "/features/:id", to: "features#update"

end
