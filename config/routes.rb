Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end
      resources :merchants, only: [:index, :show]

      namespace :invoices do
        get '/:id/transactions', to: 'transactions#index'
      end
      resources :invoices, only: [:index, :show]
      
      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
