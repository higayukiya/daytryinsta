Rails.application.routes.draw do
  devise_for :users

  root to: "tineline#index"

  resources :profile, only: [:edit, :update, :show, :destory]
  resources :timelines

  namespace :api, defaults: { format: :jason } do
    scope 'timelines/:timelines_id' do
      resources :comments, only: [:index, :create]
      resource :like, only: [:show, :create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
