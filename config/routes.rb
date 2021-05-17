Rails.application.routes.draw do
  devise_for :users

  root to: "tineline#index"

  resources :profile, only: [:edit, :update, :show, :destory]
  resources :timelines

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
