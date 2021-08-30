Rails.application.routes.draw do
  root to: 'shops#index'
  
  get 'redirects/import_redirects', to: 'redirects#import_redirects_from_api', as: 'import_redirects'
  resources :redirects
  resources :shops
end
