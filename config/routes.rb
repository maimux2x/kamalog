Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'welcome#index'

  resource :session, only: %i[destroy]
  resource :home,    only: %i[show]

  namespace :my do
    resources :pieces do
      collection do
        resources :in_progress, only: %i[index]
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
