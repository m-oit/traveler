Rails.application.routes.draw do
  
  devise_for :users
  root to: 'homes#top'
  get 'about' => 'homes#about',as: 'about'
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
  resource :favorite, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  
get '/login', to: 'sessions#new', as: 'login'
post '/login', to: 'sessions#create'
delete '/logout', to: 'sessions#destroy', as: 'logout'
root 'home#index'
end
  resources :users, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end
