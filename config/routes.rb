Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to:"landing_page#index"

  get 'register', to: 'registrations#new'
  resources :registrations, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  get 'home', to: 'pages#home'

  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'logout', to: 'sessions#destroy', as: :logout_get

  get 'user_profile', to: 'pages#user_profile'
  get 'vendor_profile', to: 'pages#vendor_profile'

  # Defines the root path route ("/")
  # root "posts#index"
end
