Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'welcome#index'

  resource :session, only: %i[destroy]
  resource :profile, only: %i[show update destroy]

  resources :invitations, only: %i[show], param: :token do
    post :accept
  end

  resources :studios, only: %i[index show new create edit update] do
    resources :settings, only: %i[index]
    resources :pieces,   only: %i[index show]
    resources :members,  only: %i[index destroy]

    resource :invitation, only: %i[create destroy], module: 'studios'

    resources :clays,  only: %i[index new create edit update destroy]

    namespace :clays do
      resource :bulk, only: %i[new create]
    end

    resources :glazes, only: %i[index new create edit update destroy]

    namespace :glazes do
      resource :bulk, only: %i[new create]
    end

    namespace :my do
      resources :pieces, only: %i[index show new create edit update destroy] do
        resources :logs, only: %i[index show new create edit update destroy]
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
