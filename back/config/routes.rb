Rails.application.routes.draw do
  # resources :environments, only: [:index, :create]
  namespace :api do
    namespace :v1 do
      resources :environments, only: [:index, :create, :show]
    end
  end
end
