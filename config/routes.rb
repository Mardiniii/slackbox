require 'api_constraints'

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
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :sessions, :only => [:create, :destroy]
      get 'data_clip/:id' => 'dashboard#data_clip'
      get 'user_panel' => 'dashboard#panel'
    end
  end
end