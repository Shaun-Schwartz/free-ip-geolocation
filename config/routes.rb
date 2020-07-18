Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'pages#main'
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'confirm/*token', to: 'users#confirm', as: :confirm_email, constraints: { token: /.*/ }
  namespace :api do
    post :geolocation, controller: :ip_addresses, action: :geolocation
  end
end
