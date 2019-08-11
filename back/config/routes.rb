Rails.application.routes.draw do
  resources :environments, only: [:index]
end
