Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    get :unpublished, on: :collection
    get :publish, on: :member
    get :unpublish, on: :member
    resources :subscriptions, only: [:create, :destroy],
              shallow: true
    resources :comments, shallow: true
  end

  resources :categories, only: [:show]

  namespace :admin do
    resources :categories
    resources :users
  end

  root 'welcome#index'

end
