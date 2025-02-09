Rails.application.routes.draw do
 
  namespace :admin do
    get 'groups/index'
    get 'groups/destroy'
  end
  namespace :admin do
    get 'top/index'
  end
  get 'group_posts/new'
  get 'group_posts/create'
  get 'group_posts/index'
  get 'group_posts/show'
  namespace :admin do
    get 'post_images/show'
  end
  devise_for :users
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
    root 'homes#top', as: 'top'
    get 'about' => 'homes#about', as: 'about'
    
      resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy, :edit, :update]
    end

    get '/search', to: 'searches#search', as: 'search'
    resources :groups, only: [:new, :index, :show, :create, :edit, :update]

      resources :users, only: [:show, :index, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      

      member do
        get :likes
        get :groups, to: "users#groups", as: "groups"
      end
    end
    
    devise_scope :user do
      post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  namespace :admin do
    root to: "dashboards#index"
    resources :dashboards, only: [:index, :show]
    resources :users, only: [:show, :destroy]
    
    resources :groups, only: [:index, :destroy, :show] do
      resources :group_posts, only: [:show]
    end
    resources :board_comments, only: [:index, :destroy]
    resources :group_post_comments, only: [:destroy] 
    
    get 'top', to: 'top#index'

    resources :post_images, only: [:show, :destroy] do
      resources :post_comments, only: [:index, :destroy]
    end
    resources :post_comments, only: [:index, :destroy]
  end
  
  resources :groups do
    member do
      get 'group_likes'
      delete 'users/:user_id', to: 'groups#destroy_user', as: 'destroy_user'
    end
    resources :permits, only: [:show, :create, :destroy, :index]
    resources :board_comments, only: [:create, :destroy]
    resources :event_notices, only: [:index, :show]
    resources :event_notice_emails, only: [:new, :create, :sent] do
      member do
        get :sent 
      end
    end
    


    resources :group_users, only: [:create, :destroy] do
      member do
        patch 'reject'
      end
      delete 'destroy_user', on: :member
    end
    resources :group_posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :group_post_comments, only: [:create, :destroy, :edit, :update]
      resource :group_favorites, only: [:create, :destroy]
    end
  end
end