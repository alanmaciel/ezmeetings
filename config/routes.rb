Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'auth/callbacks' }

  resources :companies do
    resources :buildings
  end

  get 'pages/index'
  get 'pages/about'

  root to: 'pages#index'
end
