Rails.application.routes.draw do
  root to: 'overview#index', as: :overview

  get 'login', to: 'authentication#login'
  post 'authenticate', to: 'authentication#authenticate'
  post 'logout', to: 'authentication#logout'

  resources :proposals, only: [:new, :create] do
    member do
      post 'attend'
    end
  end

  resources :requests, only: [:new, :create] do
    member do
      post 'vote'
    end
  end
end
