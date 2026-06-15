Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'welcome#index'

  resource :session, only: %i[destroy]
  resource :profile, only: %i[show update destroy]

  resources :studios, only: %i[index show] do
    resources :settings, only: %i[index]
    resources :pieces,   only: %i[index show]
    resources :clays,    only: %i[index new create edit update destroy]
    resources :glazes,   only: %i[index new create edit update destroy]

    namespace :my do
      resources :pieces, only: %i[index show new create edit update destroy] do
        resources :logs, only: %i[index show new create edit update destroy]
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
