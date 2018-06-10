Rails.application.routes.draw do
  devise_for :users
  root to: "tweets#index"

  # resources :relationships, only: [:index, :toggle_relationship]
  get 'relationships', to: 'relationships#index'
  post 'relationships', to: 'relationships#toggle_relationship'

  resources :tweets do
    resources :comments
  end
end
