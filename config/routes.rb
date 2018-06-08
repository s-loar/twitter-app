Rails.application.routes.draw do
  devise_for :users
  root to: "tweets#index"

  resources :relationships, only: [:index, :create, :destroy]

  resources :tweets do
    resources :comments
  end
end
