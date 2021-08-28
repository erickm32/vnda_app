Rails.application.routes.draw do
  root to: 'shops#index'
  
  resources :redirects
  resources :shops
end
