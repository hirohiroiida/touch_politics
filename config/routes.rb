Rails.application.routes.draw do
  root to: 'articles#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :articles

  get 'twitter/search', to: 'tweets#search'
  get 'twitter/show', to: 'tweets#show'
  resources :twitter_users
end
