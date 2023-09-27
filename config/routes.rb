Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',

  }
  get "/users/profile", to: "user#index"
  get "/users", to: "user#all_users"
  get "/users/:id", to: "user#show"
  # resources :message, only: [:index, :create]
  get "/messages/:reciever_id", to: "message#index"
  post "/send_message", to: "message#create"
end
