Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :environments
      resources :emotions_emotion_labels
      resources :emotion_labels
      resources :actions
      resources :thoughts
      resources :reactions
      resources :users do
        collection do
          post 'login'
        end
      end
    end
  end
end
