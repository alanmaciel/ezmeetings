Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'auth/callbacks' }

  root to: 'pages#index'

  get 'pages/index'
  get 'pages/about'

  resources :reservations
  resources :companies do
    resources :buildings
  end

end
