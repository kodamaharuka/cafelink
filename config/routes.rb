Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/top'
  get 'top' => 'homes#top'

  resources :genres, only: [:index,:create,:edit,:update,:show]

  resources :posts, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

end
