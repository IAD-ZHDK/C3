require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['PASSWORD_ADMIN'] && password == ENV['PASSWORD_ADMIN']
  end

  mount Sidekiq::Web => '/sidekiq'

  root to: 'clinics#index'

  get 'login', to: 'authentication#login'
  post 'authenticate', to: 'authentication#authenticate'
  post 'logout', to: 'authentication#logout'

  get 'request', to: 'request#new'
  post 'request', to: 'request#create'

  get 'propose', to: 'propose#new'
  post 'propose', to: 'propose#create'

  get 'adopt/:id', to: 'adopt#edit', as: :adopt
  patch 'adopt/:id', to: 'adopt#update'

  get 'schedule/:id', to: 'schedule#edit', as: :schedule
  patch 'schedule/:id', to: 'schedule#update'

  resources :clinics, only: [:show, :destroy] do
    member do
      get 'timeline'
      post 'vote'
      post 'attend'
      post 'comment'
    end
  end
end
