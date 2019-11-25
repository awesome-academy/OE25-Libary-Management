Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    get "borrowed/:id", to: "borroweds#show", as: "borrowed"
    post "/login", to: "sessions#create"
    post "/borrowed_details", to: "borrowed_details#create"
    delete "/logout", to: "sessions#destroy"

    resources :users
    resources :books
  end
end
