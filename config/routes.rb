Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/top'
  get 'top' => 'homes#top'
  resources :users
  resources :posts
  resources :genres
  resources :relationships
end
