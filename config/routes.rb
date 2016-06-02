Rails.application.routes.draw do
  resources :users
  root to: 'welcome#index'
  match '/signup',  to: 'users#new',            via: 'get'

end
