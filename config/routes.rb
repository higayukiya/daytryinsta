require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  devise_for :users

  root to: "timelines#index"

  resources :profile, only: [:edit, :update, :show, :destory]
  resources :timelines

  namespace :api, defaults: { format: :jason } do
    scope 'timelines/:timelines_id' do
      resources :comments, only: [:index, :create, :destory]
      resource :like, only: [:show, :create, :destroy]
    end
  end

  resources :users do
    member do
        get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
