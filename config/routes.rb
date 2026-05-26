Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'welcome#index'

  resource :session, only: %i[destroy]
  resource :home,    only: %i[show]

  namespace :my do
    resources :pieces, only: %i[index show new create edit update destroy] do
      resources :logs, only: %i[index show new create edit update destroy]
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
