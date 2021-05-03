Rails.application.routes.draw do
  devise_for :users

  root to: "articles#show"

  resources :profile, only: [:edit, :update, :show, :destory] do
    resources :timeline, only: [:create, :destory]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
