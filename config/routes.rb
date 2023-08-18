Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :destroy, :index]
      post '/login', to: 'sessions#create'

      resources :doctors, only: [:index, :create, :show, :destroy]
      resources :reservations, only: [:index, :create, :destroy]
    end
  end
end
