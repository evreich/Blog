Rails.application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  root to: 'welcome#index'
  match '/users/:id', to: 'users#make_admin' , via: 'post'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

end
