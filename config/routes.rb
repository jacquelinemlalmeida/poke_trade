Rails.application.routes.draw do
  
  resources :trade, only: [:new, :show]
  post 'trade/new', to: 'trade#create'

  get 'trades', to: 'trade#history' 
  
  resources :users, only: [:new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#logout'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'
  
  root 'sessions#welcome'
end
