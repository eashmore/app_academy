Rails.application.routes.draw do
  resources :users, except: [:index] do
    resources :goals, only: :new
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:new, :index]
end
