Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "products#index"
  # get 'users/logout' to: 'user#logout'
  resources :products, only: [:index]
  resources :informations, only: [:index]
  # resources :users, only: [:index]
  resources :users do
    collection do
      get :logout
      get :howToPay
    end
  end 
end
