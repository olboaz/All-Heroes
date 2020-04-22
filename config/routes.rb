Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :heroes
  resources :users, except: [ :index, :destroy ]
  resources :publisers, only: [:new, :create]
  resources :contacts, only: [:new, :create]
end
