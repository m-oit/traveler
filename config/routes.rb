Rails.application.routes.draw do
 
  devise_for :users
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    
    resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    resources :users, only: [:show, :edit, :update, :destroy]
    
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
end