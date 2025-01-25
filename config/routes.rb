Rails.application.routes.draw do
 
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

  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resources :group_users, only: [:show, :create, :destroy]
  end

  namespace :admin do
    resources :dashboards, only: [:index, :show]
    resources :users, only: [:show, :destroy]
    resources :post_images, only: [:show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end

    
end