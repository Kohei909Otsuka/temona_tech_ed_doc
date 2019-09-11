Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  resources :rooms, only: [:index]
  post "/login", to: "auth#create"
  delete "/logout", to: "auth#destroy"
end
