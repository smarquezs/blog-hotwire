Rails.application.routes.draw do
  resources :authors
  resources :posts
  root "posts#index"
end
