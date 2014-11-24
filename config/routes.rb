SampleApp::Application.routes.draw do
  resources :members do
    resources :memberships, only: [:new, :create, :edit, :update ]
    get 'dashboard', on: :collection
  end

  resources :users, only: [:edit, :update]


  resources :sessions, only: [:new, :create, :destroy]

  root to: 'sessions#new'

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/copyrights', to: 'static_pages#copyrights', via: 'get'

end
