Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'login', to: 'sessions#new'

  root to: 'home#index'

  get 'up' => 'rails/health#show', as: :rails_health_check
end
