Rails.application.routes.draw do
  
devise_for :admins
  namespace :admin do
    resources :shops,only: [:index, :edit, :create, :destroy, :update]
  	resources :genres,only:  [:top, :index, :show, :new, :edit, :create, :destroy, :update]
  	get 'top'=>'products#top'
  end

  devise_for :users,:controllers => {
      :sessions => "devise/users/sessions",
      :registrations => "devise/users/registrations",
      :passwords => "devise/users/passwords"
    }
    
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Admin側
  namespace :admin do
    # TopページをHomeに変更
    get '/' => 'homes#top'
    # get "search/homes" => "homes#search", as: 'homes_search'

    #get 'shops/' => 'shops#show', as: 'shop'
    get 'shops/edit' => 'shops#edit', as: 'shop_edit'
    patch 'shops/' => 'shops#update', as: 'shop_update'
    delete 'shops/' => 'shops#destroy', as: 'shop_destroy'
    get 'search/shops' => 'shops#search', as: 'shops_search'
    resources :shops, only: %i[index create]

    resources :genres, except: %i[new show destroy]
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
    
    # フォロー機能
    resources :relationships, only: %i[create destroy]
    get 'relationships/follows' => 'relationships#follow', as: 'relationships_follows'
    get 'relationships/followers' => 'relationships#follower', as: 'relationships_followers'
    
    
    # カテゴリー検索
    get 'genre/search' => 'homes#search', as: 'search_shops'
    get 'shops/' => 'shops#show', as: 'shop'
    resources :ahops, only: [:index] do
      # レビュー機能
      resources :reviews do
        resources :comments, only: %i[create destroy]
        resource :likes, only: %i[create destroy]
      end
      # Tag機能
      resources :tags, only: %i[create destroy] # do
      # get 'search', to: 'tag#search'
      # end
    end
    get 'tags/:tag_name/search' => 'tags#search', as: 'tag_search'
  end
end

