Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  root to: 'homes#top'
  devise_for :users
  resources :post_images, only: [:new, :create, :index, :show]

  get 'about' => 'homes#about',as: 'about'
  end
