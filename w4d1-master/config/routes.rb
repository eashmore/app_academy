Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :contacts, only: :index
  end
  resources :contacts, only: [:show, :create, :update, :destroy]
  resources :contact_shares, only: [:create, :destroy]
end
