Rails.application.routes.draw do
  devise_for :users
  get 'homes/index'
  root to: "items#index"
end
