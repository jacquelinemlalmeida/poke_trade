Rails.application.routes.draw do
  
  resources :trade, only: [:new, :show]
  post 'trade/new', to: 'trade#create'
  get 'trade/calculate_base_experience', to: 'trade#calculate_base_experience'

  get 'trade_history/show'
  
  resources :users, only: [:new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'
  
  root 'sessions#welcome'
end
