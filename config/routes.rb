Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#index"

  get 'register', to: 'registrations#new'
  resources :registrations, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'


  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'logout', to: 'sessions#destroy', as: :logout_get

  get 'user_profile', to: 'pages#user_profile'
  get 'vendor_profile', to: 'pages#vendor_profile'

  get 'home', to: 'pages#home', as: :home

  get 'family_occasions', to: 'pages#family_occasions'
  get 'social_events', to: 'pages#social_events'
  get 'destination_wedding', to: 'pages#destination_wedding'
  get 'pandit_ji', to: 'pages#pandit_ji'

  get '/payments', to: 'pages#payment', as: 'payment'
  post '/payments', to: 'pages#make_payment', as: 'make_payment'

  post '/accept_booking/:id', to: 'pages#accept_booking', as: 'accept_booking'
  delete '/reject_booking/:id', to: 'pages#reject_booking', as: 'reject_booking'



  post '/update_rating', to: 'pages#update_rating'
  post 'update_vendor_rating', to: 'pages#update_vendor_rating', as: 'update_vendor_rating'



end
