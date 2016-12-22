Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  resources :users

  resources :category, only: :index do
    resources :lessons, except: [:index, :new, :destroy]
  end

  namespace :admin do
    root "users#index"
    resources :users
    resources :categories do
      resources :words
    end
    resources :words
  end

  resources :categories do
    resources :lessons
  end
  resources :words
end
