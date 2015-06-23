Rails.application.routes.draw do
  resources :users
  resources :subs, except: :destroy do
    resources :posts, only: [:new, :create]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :posts, except: [:new, :create, :index, :destroy] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]
end
