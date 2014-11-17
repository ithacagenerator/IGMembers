IGMembers::Application.routes.draw do
  resources :members
  resources :users, only: [:edit, :update]
  resources :memberships, only: [:new, :create, :edit, :update ]
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets


  root to: 'members#index'

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/copyrights', to: 'static_pages#copyrights', via: 'get'
end
