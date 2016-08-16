Rails.application.routes.draw do
  resources :command_requests, only: [:create] do
    collection do
      get :auth_grant
    end
  end
  get 'hello_world', to: 'hello_world#index'
  root 'pages#index'
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'panel' => 'dashboard#panel'
  resources :dashboard, only: [:show]
  get 'pages/index'
end
