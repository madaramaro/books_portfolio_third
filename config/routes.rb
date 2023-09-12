Rails.application.routes.draw do
  devise_for :users
  get 'cards/new'
  get 'cards/create'
  root to: "test_styles#index"
  resources :books, only: [:new, :create, :index, :edit, :update]

  # config/routes.rb

resources :books do
  resources :cards, only: [:new, :create]
end

resources :cards


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
