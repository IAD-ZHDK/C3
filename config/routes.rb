Rails.application.routes.draw do
  root to: 'clinics#index'

  get 'login', to: 'authentication#login'
  post 'authenticate', to: 'authentication#authenticate'
  post 'logout', to: 'authentication#logout'

  get 'request', to: 'request#new'
  post 'request', to: 'request#create'

  get 'propose', to: 'propose#new'
  post 'propose', to: 'propose#create'

  resources :clinics, only: [:show] do
    member do
      post 'vote'
      post 'propose'
      post 'attend'
    end
  end
end
