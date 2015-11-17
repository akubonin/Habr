Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, shallow: true
  end

  resources :categories

  root 'welcome#index'

end
