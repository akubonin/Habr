Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, shallow: true
  end

  resources :categories, only: [:show]

  namespace :admin do
    resources :categories
    resources :users
  end

  root 'welcome#index'

end
