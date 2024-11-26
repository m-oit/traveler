Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :users

  resources :users, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :post_images, only: [:new, :create, :index, :show, :destroy]

  get 'about' => 'homes#about',as: 'about'
  end
