Rails.application.routes.draw do
  
devise_for :admins, controllers: {
    sessions: 'devise/admins/sessions',
    passwords: 'devise/admins/passwords',
    registrations: 'devise/admins/registrations'
  }
  
  devise_for :users,:controllers => {
      :sessions => "devise/users/sessions",
      :registrations => "devise/users/registrations",
      :passwords => "devise/users/passwords"
    }
    
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Admin側
  namespace :admin do
    # TopページをHomeに変更
    get '/' => 'homes#top'
    # get "search/homes" => "homes#search", as: 'homes_search'

    #get 'shops/' => 'shops#show', as: 'shop'
    get 'shops/edit/:id' => 'shops#edit', as: 'shop_edit'
    patch 'shops/:id' => 'shops#update', as: 'shop_update'
    delete 'shops/:id' => 'shops#destroy', as: 'shop_destroy'
    get 'search/shops' => 'shops#search', as: 'shops_search'
    resources :shops, only: %i[index create new show]

    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: %i[index show]
  end



# User側
  scope module: :public do
    # Topページ
    root to: 'homes#top'
    # aboutページ
    get 'homes/about' => 'homes#about'
    
    # user周りのルート
    resources :users, except: %i[new create destroy]
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'user_unsubscribe'
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'user_withdraw'
    get 'search' => 'users#search', as: 'user_search'
    #post 'users/:id' => 'posts#index' #, as: 'post_index'
    
    # フォロー機能
    resources :relationships, only: %i[create destroy]
    get 'relationships/followings' => 'relationships#followings', as: 'followings'
    get 'relationships/followers' => 'relationships#followers', as: 'followers'
    
    # 投稿機能
    resources :posts, only: [:show, :edit, :new, :create, :update, :destroy, :index] do
      #member do
        #get :index
        #get '/users/:id' => ''
      #end
      
      #resources :comments, only: %i[create destroy]
    resources :comments, only: [:create, :destroy]

      #resources :likes, only: %i[create destroy]
      resource :likes, only: [:create, :destroy]
      end
      
    resources :shops, only: [:index, :show] 
    
    get 'genres/kids' => 'genres#kids'
    get 'genres/solo' => 'genres#solo'
    get 'genres/date' => 'genres#date'
    get 'genres/interior' => 'genres#interior'
    get 'genres/pet' => 'genres#pet'
    get 'genres/sweets' => 'genres#sweets'
    get 'genres/alcohol' => 'genres#alcohol'
    
    # カテゴリー検索
    get 'genre/search' => 'homes#search', as: 'search_shops'
    #get 'shops/' => 'shops#show', as: 'shop'

  end
end