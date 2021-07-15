Rails.application.routes.draw do

  # resources :users

  # get "logout", to: "users#logout"
  # get "login", to: "users#login"
  # post "sessions", to: "users#sessions"
  # get "profile", to: "users#profile"

  post "rewards", to: "rewards#calculate"
  root "users#new"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
