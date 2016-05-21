Rails.application.routes.draw do
  resources :command_requests, only: [:create]
  root 'pages#index'
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'panel' => 'dashboard#panel'
  get 'pages/index'
end
