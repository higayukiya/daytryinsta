Rails.application.routes.draw do
  devise_for :users

  root to: "timelines#index"

  resources :profile, only: [:edit, :update, :show, :destory]

  resources :timelines do
    resources :comments, only: [:index, :create, :destory]
  end

  namespace :api, defaults: { format: :jason } do
    scope 'timelines/:timelines_id' do
      resource :like, only: [:show, :create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
