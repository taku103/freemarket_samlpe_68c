Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "signup_users#index"
  resources :products, only: [:index, :new]
  resources :informations, only: [:index , :show]
  resources :tests, only: :show do
    collection do
      get :pay
      get :done
    end
  end 
  resources :signup_users, only: :new 
  resources :users, only: :index do
    collection do
      get :logout
      get :howToPay
    end
  end 

  resources :signin_users, only: [:show]
  resources :signup_users, only: [:index] do
    collection do
      get :done
      get :address
    end
  end
end
