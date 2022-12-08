Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    resources :users
    resources :branch_offices
    resources :opening_hours
    resources :shifts
    resources :dashboards
    resources :admin_users
  end
  # add prefix to route users
  devise_for :users, path: "my"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Las rutas de branch_offices son solo show , index , and opening_hours
  resources :branch_offices, only: [:index, :show, :opening_hours] do
    collection do
      get :opening_hours
    end
  end

  resources :shifts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
end
