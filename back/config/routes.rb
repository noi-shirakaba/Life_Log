Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :environments, only: [:index, :create, :show, :update, :destroy]
      resources :emotions_emotion_labels, only: [:create]
      resources :emotion_labels, only: [:create]
      resources :actions, only: [:create]
      resources :thoughts, only: [:create]
      resources :reactions, only: [:create]
      resources :users do
        collection do
          post 'login'
        end
      end
    end
  end
end
