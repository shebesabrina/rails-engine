Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :update, :destroy]

      get "/merchants/:id/items", to: 'merchants#show'
    end
  end
end
