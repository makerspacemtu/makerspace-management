Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :users do
    get :password, on: :member
    patch :update_password, on: :member
  end
end
