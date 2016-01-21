Rails.application.routes.draw do
  root to: 'clinics#index'

  get 'login', to: 'authentication#login'
  post 'authenticate', to: 'authentication#authenticate'
  post 'logout', to: 'authentication#logout'

  get 'request', to: 'request#new'
  post 'request', to: 'request#create'

  get 'propose', to: 'propose#new'
  post 'propose', to: 'propose#create'

  get 'schedule', to: 'schedule#new'
  post 'schedule', to: 'schedule#create'

  get 'adopt/:id', to: 'adopt#edit', as: :adopt
  patch 'adopt/:id', to: 'adopt#update'

  resources :clinics, only: [:show] do
    member do
      post 'vote'
      post 'attend'
    end
  end
end
