Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"

    devise_scope :user do
      get "/signup", to: "devise/registrations#new"
      post "/signup", to: "devise/registrations#create"
      get "/edit-profile", to: "devise/registrations#edit"
      put "/edit-profile", to: "devise/registrations#update"
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
    end

    get "admin/dashboard", to: "admin#dashboard"
    post "/borrowed_details", to: "borrowed_details#create"

    devise_for :users

    resources :users, only: :show
    resources :books
    resources :borroweds, except: %i(create new)
    resources :borrowed_details, only: %i(create destroy)
    resources :borroweds, only: %i(show)
    resources :comments, only: %i(create destroy)
    resources :account_activations, only: :edit

    namespace :admin do
      resources :books
      resources :users
      resources :comments, only: %i(destroy index)
      resources :borroweds, only: %i(index show update)
      resources :authors
      resources :publishers
    end
  end
end
