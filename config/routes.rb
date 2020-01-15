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
    resources :user_signups
  end

  resources :trainings

  resources :signups

  resources :daily_reports

  resources :events

  #resources :surveys

  # checkin related routes
  get '/checkin', to: 'checkin#index'
  get '/checkin/first_time', to: 'checkin#first_time'
  get '/checkin/checkin_history', to: 'checkin#checkin_history'
  post '/checkin', to: 'checkin#checkin'
  post '/slack/checkin', to: 'slack#checkin'
  post '/slack/checkout', to: 'slack#checkout'
  post '/checkin/checkout_all', to: 'checkin#checkout_all'

  # survey related routes
  get '/surveys/new', to: 'surveys#new'
  # get '/surveys/new' to: 'surveys#new'

  post '/surveys', to: 'surveys#create'

  # signup related routes
  post '/signups/dropsignup', to: 'signups#dropsignup'

  # setting related routes
    #Open or close the signups for coaches
  get '/settings/toggle_signup_status', to: 'settings#toggle_signup_status'
  post '/settings/toggle_signup_status', to: 'settings#toggle_signup_status'
    #Toggle admin view
  get '/settings/toggle_admin_view', to: 'settings#toggle_admin_view'
  post '/settings/toggle_admin_view', to: 'settings#toggle_admin_view'
    #toggle deficient trainings display on signups page
  get '/settings/toggle_deficient_trainings_view', to: 'settings#toggle_deficient_trainings_view'
  post '/settings/toggle_deficient_trainings_view', to: 'settings#toggle_deficient_trainings_view'

  # training related routes
  post '/trainings/droptraining', to: 'trainings#droptraining'
  post '/trainings/nullifyagreements', to: 'trainings#nullifyagreements'
  # misc. static slack routes
  get '/slack/auth', to: 'slack#auth'
  post '/slack/buttons', to: 'slack#buttons'
  post '/slack/events', to: 'slack#events'
end
