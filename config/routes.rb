Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',

  }
  get "/users/profile", to: "user#index"
  resources :message, only: [:index, :create]
end
