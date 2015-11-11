Rails.application.routes.draw do
  resources :posts do
    resources :comments, shallow: true
  end

  resources :categories

  root 'welcome#index'

end
