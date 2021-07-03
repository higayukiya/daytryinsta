require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
