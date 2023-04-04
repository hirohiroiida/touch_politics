Rails.application.routes.draw do
  root to: 'twitter_users#index'
  
  resources :tweets
  resources :twitter_users
end
