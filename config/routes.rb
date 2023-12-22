Rails.application.routes.draw do
  get 'homes/index'
  root to: "items#index"
end
