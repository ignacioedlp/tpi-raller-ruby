Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    resources :users
  end
  # add prefix to route users 
  devise_for :users , path: 'my'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :branch_offices, only: [:index, :show]
  resources :shifts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
end
