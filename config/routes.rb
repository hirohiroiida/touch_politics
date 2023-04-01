Rails.application.routes.draw do
  root to: 'articles#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :articles

  resources :tweets
  resources :twitter_users
end
