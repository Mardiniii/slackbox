Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :command_requests, only: [:create] do
    collection do
      get :auth_grant
    end
  end
  resources :command_requests, only: [:create]
  resources :dashboard, only: [:show]

  get 'panel' => 'dashboard#panel'
  get 'pages/index'

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do

  end

end
