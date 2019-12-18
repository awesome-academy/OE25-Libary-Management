Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "admin/dashboard", to: "admin#dashboard"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    post "/borrowed_details", to: "borrowed_details#create"
    delete "/logout", to: "sessions#destroy"

    resources :users
    resources :books
    resources :borroweds, except: %i(create new)
    resources :borrowed_details, only: %i(create destroy)
    resources :borroweds, only: %i(show)
    resources :comments, only: %i(create destroy)
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :categorys, only: %i(index show)

    namespace :admin do
      resources :books
      resources :comments, only: %i(destroy index)
      resources :authors, only: %i(index show)
    end
  end
end
