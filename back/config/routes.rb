Rails.application.routes.draw do

  devise_for :users
  root to: 'environments#index'
  resources :environments, only: [:index, :create]
end
