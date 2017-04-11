Rails.application.routes.draw do
  devise_for :users

  # landing page
  root 'home#index'

  resources :users do
    get :coaches, on: :collection
    get :metrics, on: :collection
    get :password, on: :member
    patch :update_password, on: :member
    resources :user_trainings, only: [:new, :create, :destroy]
  end

  resources :trainings

  # checkin related routes
  get '/checkin', to: 'checkin#index'
  get '/checkin/first_time', to: 'checkin#first_time'
  post '/checkin', to: 'checkin#checkin'
  post '/slack/checkin', to: 'slack#checkin'
  post '/slack/checkout', to: 'slack#checkout'

  # training related routes
  post '/slack/training', to: 'slack#training'

  # misc. static slack routes
  get '/slack/auth', to: 'slack#auth'
  post '/slack/actions', to: 'slack#actions'
  post '/slack/actions/external', to: 'slack#external'
  post '/slack/events', to: 'slack#events'
end
