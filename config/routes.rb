Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'pages#home'
  get 'docs', to: 'pages#docs', as: :docs
  resources :api_keys, only: [:index, :create]
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  # confirmable
  get 'confirm/*token', to: 'users#confirm', as: :confirm_email, constraints: { token: /.*/ }
  # resettable
  get 'reset_password', to: 'users#reset_password_request_form', as: :reset_password_request_form
  post 'reset_password_request', to: 'users#reset_password_request', as: :reset_password_request
  get 'reset_password/*token', to: 'users#reset_password_form', as: :reset_password_form, constraints: { token: /.*/ }
  post 'reset_password/*token', to: 'users#reset_password', as: :reset_password, constraints: { token: /.*/ }

  namespace :api do
    post :geolocation, controller: :ip_addresses, action: :geolocation
  end
end
