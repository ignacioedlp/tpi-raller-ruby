Rails.application.routes.draw do
  resources :opening_hours
  resources :branch_offices
  # add prefix to route users 
  devise_for :users , path: 'my'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
end
